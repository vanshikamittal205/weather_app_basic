import 'package:flutter/material.dart';
import 'package:weather_app/Service/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

Future<void> openAppSettingsIfNeeded() async {
  if (await Permission.location.isPermanentlyDenied) {
    await openAppSettings();
  }
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService= WeatherService('c296781bd25a6c663beaa21ca9e751c2'
  );
  Weather? _weather;

  //fetch weather

  _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // Show alert if location permission is denied
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Location Error"),
          content: Text("Failed to fetch location. Please enable location permissions in settings."),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK")
            )
          ],
        ),
      );
      print("Error: $e");
    }
  }


  //weather animations
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition==null)
      return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()){
      case 'clouds':

      case 'mist':

      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';

      case 'thunderstorm':
        return 'assets/thunder.json';

      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';

    }
  }
  
  //initial state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // city name
              Text(
                _weather?.cityName ?? 'Loading City...',
                style: TextStyle(fontSize: 24),
              ),

              // weather animation
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

              // temperature
              Text(
                _weather != null
                    ? '${_weather!.temperature.round()}°C'
                    : 'Loading temperature...',
                style: TextStyle(fontSize: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }}
