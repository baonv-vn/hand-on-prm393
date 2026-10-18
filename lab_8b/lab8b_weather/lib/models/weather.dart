class Weather {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final double precipitation;
  final int weatherCode;
  final int? rainChance;
  final double? tempMax;
  final double? tempMin;

  const Weather({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
    required this.weatherCode,
    this.rainChance,
    this.tempMax,
    this.tempMin,
});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>?;

    T? firstOf<T>(String key) {
      final list = daily?[key] as List<dynamic>?;
      if (list == null || list.isEmpty) return null;
      return list.first as T?;
    }

    return Weather(
      temperature: (current['temperature_2m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).round(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      precipitation: (current['precipitation'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
      rainChance: (firstOf<num>('precipitation_probability_max'))?.round(),
      tempMax: (firstOf<num>('temperature_2m_max'))?.toDouble(),
      tempMin: (firstOf<num>('temperature_2m_min'))?.toDouble(),
    );
  }
}