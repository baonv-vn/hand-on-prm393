import 'package:flutter/material.dart';
import '../models/weather_result.dart';
import '../services/weather_service.dart';
import '../widgets/error_view.dart';
import '../widgets/weather_card.dart';
import '../logic/advice.dart';
import '../widgets/advice_card.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _service = WeatherService();
  final _controller = TextEditingController();
  Future<WeatherResult?>? _future;
  String _query = '';

  Future<WeatherResult?> _load(String query) async {
    final cities = await _service.searchCities(query);
    if (cities.isEmpty) return null;
    final city = cities.first;
    final weather = await _service.fetchWeather(city.latitude, city.longitude);
    return WeatherResult(city, weather);
  }

  void _search() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _query = query;
      _future = _load(query);
    });
  }

  void _retry() => setState(() => _future = _load(_query));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Companion')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _search(),
                    decoration: const InputDecoration(
                      hintText: 'Nhập tên thành phố',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(onPressed: _search, icon: const Icon(Icons.search)),
              ],
            ),
          ),
          Expanded(child: _buildResult()),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final future = _future;
    if (future == null) {
      return const Center(child: Text('Nhập tên thành phố để xem thời tiết.'));
    }
    return FutureBuilder<WeatherResult?>(
      future: future,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return ErrorView(message: '${snap.error}', onRetry: _retry);
        }
        final result = snap.data;
        if (result == null) {
          return Center(child: Text('Không tìm thấy "$_query". Thử tên khác?'));
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(result.city.displayName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            WeatherCard(weather: result.weather),
            const SizedBox(height: 8),
            AdviceCard(icon: Icons.umbrella, advice: umbrellaAdvice(result.weather)),
            AdviceCard(icon: Icons.directions_run, advice: outdoorAdvice(result.weather)),
          ],
        );
      },
    );
  }
}
