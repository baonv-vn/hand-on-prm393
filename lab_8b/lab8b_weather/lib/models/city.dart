class City {
  final String name;
  final String? admin1;
  final String country;
  final double latitude;
  final double longitude;

  const City({
    required this.name,
    this.admin1,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] as String,
      admin1: json['admin1'] as String?,
      country: (json['country'] as String?) ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  String get displayName {
    final province = admin1;
    return [
      name,
      if (province != null && province != name) province,
      if (country.isNotEmpty) country,
    ].join(', ');
  }
}
