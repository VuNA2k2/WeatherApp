import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/services/locations_service.dart';
import 'package:weather_app/services/weather_service.dart';

import '../data/repository/locations_repository.dart';

final getIt = GetIt.instance;

configureInjection() async {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerLazySingleton<LocationsAPI>(() => LocationsAPI(getIt<Dio>()));
  getIt.registerLazySingleton<LocationRepository>(() => LocationRepository(api: getIt.get<LocationsAPI>()));

  getIt.registerLazySingleton<WeatherAPI>(() => WeatherAPI(getIt<Dio>()));
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepository(api: getIt.get<WeatherAPI>()));


  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);
}
