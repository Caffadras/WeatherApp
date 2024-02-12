import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService("bdf90d3f7612a331c3f089df6b189e48");
  Weather? weather;

  void fetchWeather() async {
    print("fetchweather");

    String cityName = await weatherService.getCityName();

    try {
      final newWeather = await weatherService.getWeather(cityName);
      setState(() {
        weather = newWeather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? condition) {
    const base = "assets";

    if (condition == null) return "$base/Loading.json";

    switch (condition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "$base/Windy.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "$base/Rainny_Day.json";
      case "thunderstorm":
        return "$base/Thunder.json";
      default:
        return "$base/Sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();

    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(getWeatherAnimation(weather?.condition)),
            Text(
              weather?.condition ?? "Loading data...",
              style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              weather?.displayedTemp ?? "",
              style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
            ),
            Text(
              weather?.cityName ?? "",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
