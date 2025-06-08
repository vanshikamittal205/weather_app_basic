import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

  final String apiKey;
  
  WeatherService(this.apiKey);
  
  Future<Weather> getWeather(String cityName) async{
    final response= await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if(response.statusCode==200){
      return Weather.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission permanently denied.");
    }

    // Now get the position
    // Step 2: Define modern settings (new way)
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, // You can also use LocationAccuracy.best
      distanceFilter: 10,
    );

    // Step 3: Get position
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );


    // Step 4: Reverse geocoding
    final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    final city = placemarks.first.locality;

    return city ?? "Unknown";
  }

}