import 'package:flutter_test/flutter_test.dart';
import 'package:lab8b_weather/models/city.dart';

void main() {
  test('City day du -> displayName co du 3 phan', () {
    final c = City.fromJson({
      'name': 'Paris',
      'admin1': 'Ile-de-France',
      'country': 'France',
      'latitude': 48.85,
      'longitude': 2.35,
    });
    expect(c.displayName, 'Paris, Ile-de-France, France');
  });

  test('City thieu admin1 va country -> khong crash', () {
    final c = City.fromJson({'name': 'X', 'latitude': 1, 'longitude': 2});
    expect(c.admin1, isNull);
    expect(c.country, '');
    expect(c.latitude, 1.0);
    expect(c.displayName, 'X');
  });
}
