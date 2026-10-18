import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/city.dart';
import '../models/weather.dart';

class WeatherException implements Exception {
  final String message;
  const WeatherException(this.message);
  @override
  String toString() => message;
}

class WeatherService {
  WeatherService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  Future<List<City>> searchCities(String query) async {
    final q = query.trim();
    if (q.isEmpty) return [];
    final uri = Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
      'name': q,
      'count': '5',
      'language': 'vi',
    });
    final data = await _getJson(uri);
    final results = data['results'] as List<dynamic>?;
    if (results == null) return [];
    return results
        .map((e) => City.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Weather> fetchWeather(double lat, double lon) async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '$lat',
      'longitude': '$lon',
      'current': 'temperature_2m,apparent_temperature,relative_humidity_2m,'
          'precipitation,weather_code,wind_speed_10m',
      'daily': 'precipitation_probability_max,temperature_2m_max,'
          'temperature_2m_min',
      'timezone': 'auto',
    });
    final data = await _getJson(uri);
    try {
      return Weather.fromJson(data);
    } on TypeError {
      throw const WeatherException('Dữ liệu thời tiết không hợp lệ.');
    }
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final res = await _client.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) {
        throw WeatherException('Máy chủ trả về lỗi (${res.statusCode}).');
      }
      return json.decode(res.body) as Map<String, dynamic>;
    } on TimeoutException {
      throw const WeatherException('Hết thời gian chờ. Vui lòng thử lại.');
    } on http.ClientException {
      throw const WeatherException('Không có kết nối mạng.');
    } on FormatException {
      throw const WeatherException('Dữ liệu trả về không hợp lệ.');
    }
  }
}
