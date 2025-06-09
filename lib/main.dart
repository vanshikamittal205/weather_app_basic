import 'package:flutter/material.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'pages/weather_page.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
      // home: HomeScreen(),
      // title: 'Weather',
    );
  }
}
