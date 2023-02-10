import 'package:flutter/material.dart';
import 'package:weather_app/view/home_screen/home_screen.dart';

import 'di/network_injection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
