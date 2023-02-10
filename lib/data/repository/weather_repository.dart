import 'package:dio/dio.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherRepository {
  final WeatherAPI api;

  WeatherRepository({required this.api});

  Future<Response> getWeatherByLocationAtDate({required int locationId, required DateTime date}) => api.getWeatherByLocationAtDate(locationId: locationId, date: date);
}
