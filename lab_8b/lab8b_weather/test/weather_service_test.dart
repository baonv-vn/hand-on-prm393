import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab8b_weather/services/weather_service.dart';

void main() {

  test('khong tim thay -> list rong', () async {
    final svc = WeatherService(
      client: MockClient((_) async =>
      http.Response('{"generationtime_ms":0.1}', 200)),
    );
    expect(await svc.searchCities('asdfghjkl'), isEmpty);
  });

  test('status 500 -> WeatherException', () async {
    final svc = WeatherService(
      client: MockClient((_) async => http.Response('error', 500)),
    );
    expect(svc.fetchWeather(21, 105), throwsA(isA<WeatherException>()));
  });

  test('JSON rac -> WeatherException', () async {
    final svc = WeatherService(
      client: MockClient((_) async => http.Response('<html>', 200)),
    );
    expect(svc.fetchWeather(21, 105), throwsA(isA<WeatherException>()));
  });

  test('mat mang -> WeatherException', () async {
    final svc = WeatherService(
      client: MockClient((_) async => throw http.ClientException('no internet')),
    );
    expect(svc.fetchWeather(21, 105), throwsA(isA<WeatherException>()));
  });

  test('co ket qua -> list City', () async {
    const body = '{"results":[{"name":"Paris","latitude":48.85,"longitude":2.35,"country":"France"}]}';
    final svc = WeatherService(
      client: MockClient((_) async => http.Response(body, 200)),
    );
    final cities = await svc.searchCities('Paris');
    expect(cities, hasLength(1));
    expect(cities.first.name, 'Paris');
    expect(cities.first.admin1, isNull);
  });

  test('fetchWeather thanh cong', () async {
    const body = '{"current":{"temperature_2m":29.5,"apparent_temperature":32,'
        '"relative_humidity_2m":70,"wind_speed_10m":12.3,"precipitation":0.0,'
        '"weather_code":3}}';
    final svc = WeatherService(
      client: MockClient((_) async => http.Response(body, 200)),
    );
    final w = await svc.fetchWeather(21.03, 105.85);
    expect(w.temperature, 29.5);
    expect(w.rainChance, isNull);
  });

  test('body la mang [] -> hien tai nem TypeError (khoang ho)', () async {
    final svc = WeatherService(
      client: MockClient((_) async => http.Response('[]', 200)),
    );
    expect(svc.fetchWeather(21, 105), throwsA(isA<TypeError>()));
  });
}