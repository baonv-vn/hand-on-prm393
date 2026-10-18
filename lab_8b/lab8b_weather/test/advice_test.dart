import 'package:flutter_test/flutter_test.dart';
import 'package:lab8b_weather/logic/advice.dart';
import 'package:lab8b_weather/models/weather.dart';

Weather makeWeather({int? rainChance, double precipitation = 0, double feelsLike = 25}) {
  return Weather(
    temperature: 25,
    feelsLike: feelsLike,
    humidity: 60,
    windSpeed: 5,
    precipitation: precipitation,
    weatherCode: 0,
    rainChance: rainChance,
  );
}

void main() {
  group('umbrellaAdvice', () {
    test('rainChance 80 -> nen mang o', () {
      expect(umbrellaAdvice(makeWeather(rainChance: 80)).title, 'Nên mang ô');
    });
    test('rainChance 10, khong mua -> khong can', () {
      expect(umbrellaAdvice(makeWeather(rainChance: 10)).title, 'Không cần mang ô');
    });
    test('thieu rainChance, khong mua -> khong crash', () {
      expect(umbrellaAdvice(makeWeather()).title, 'Không cần mang ô');
    });
    test('bien nguong rainChance 50 -> nen mang o', () {
      expect(umbrellaAdvice(makeWeather(rainChance: 50)).title, 'Nên mang ô');
    });
  });

  group('outdoorAdvice', () {
    test('feelsLike 36 -> qua nong', () {
      expect(outdoorAdvice(makeWeather(feelsLike: 36)).title, 'Quá nóng để tập ngoài trời');
    });
    test('bien nguong nong feelsLike 35 -> qua nong', () {
      expect(outdoorAdvice(makeWeather(feelsLike: 35)).title, 'Quá nóng để tập ngoài trời');
    });
    test('feelsLike 15 -> kha lanh', () {
      expect(outdoorAdvice(makeWeather(feelsLike: 15)).title, 'Khá lạnh');
    });
  });

  group('describeWeatherCode', () {
    test('code 0 -> troi quang', () => expect(describeWeatherCode(0), 'Trời quang'));
    test('code la 999 -> khong xac dinh', () => expect(describeWeatherCode(999), 'Không xác định'));
  });
}
