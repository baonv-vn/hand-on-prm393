import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab8b_weather/models/weather.dart';

void main() {
  test('parse JSON day du', () {
    const body = '''{"current":{"temperature_2m":29.5,"apparent_temperature":32,
      "relative_humidity_2m":70,"wind_speed_10m":12.3,"precipitation":0.0,
      "weather_code":3},
      "daily":{"precipitation_probability_max":[70],
      "temperature_2m_max":[33.1],"temperature_2m_min":[26.0]}}''';
    final w = Weather.fromJson(json.decode(body) as Map<String, dynamic>);
    expect(w.temperature, 29.5);
    expect(w.feelsLike, 32.0);
    expect(w.rainChance, 70);
  });

  test('thieu daily -> truong phu la null', () {
    const body = '''{"current":{"temperature_2m":20,"apparent_temperature":20,
      "relative_humidity_2m":50,"wind_speed_10m":5,"precipitation":0,
      "weather_code":0}}''';
    final w = Weather.fromJson(json.decode(body) as Map<String, dynamic>);
    expect(w.rainChance, isNull);
  });
}
