part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  Weather weather;
  List<Weather> listWeatherOnWeek;
  WeatherStateSuccess({required this.weather, required this.listWeatherOnWeek});
}

class WeatherStateFail extends WeatherState {}