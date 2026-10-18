import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../logic/advice.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final high = weather.tempMax;
    final low = weather.tempMin;
    final chance = weather.rainChance;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${weather.temperature.round()}\u00B0C',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(describeWeatherCode(weather.weatherCode)),
            const SizedBox(height: 8),
            Text('Cảm giác như ${weather.feelsLike.round()}°C'),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.water_drop, text: 'Độ ẩm ${weather.humidity}%'),
            _InfoRow(icon: Icons.air, text: 'Gió ${weather.windSpeed.round()} km/h'),
            if (chance != null) _InfoRow(icon: Icons.umbrella, text: 'Khả năng mưa $chance%'),
            if (high != null && low != null)
              _InfoRow(icon: Icons.thermostat, text: 'Thấp ${low.round()}° / Cao ${high.round()}°'),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
