class Weather {
  final String cityName;
  final double temperature;
  final String condition;

  Weather({required this.cityName, required this.temperature, required this.condition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] as String,
      temperature: json['main']['temp'] as double,
      condition: json['weather'][0]['main'] as String,
    );
  }

  String get displayedTemp {
    return "${temperature.round()} C";
  }
}
