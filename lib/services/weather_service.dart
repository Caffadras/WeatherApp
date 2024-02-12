import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;


class WeatherService{
  static const String BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);


  Future<Weather> getWeather(String cityName) async {
    var uri = Uri.parse("$BASE_URL?q=$cityName&appId=$apiKey&units=metric");
    final response = await http.get(uri);

    if (response.statusCode == 200){
      print((response.body));
      print(jsonDecode(response.body));
      return Weather.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to load the weather data: " + response.body);
  }


  Future<String> getCityName() async {
     LocationPermission permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied){
       permission = await Geolocator.requestPermission();
     }

     Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);

     print("position $position");
     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    print("placemarks $placemarks");
     String? city = placemarks[0].locality;


     return city ?? "";
  }
}