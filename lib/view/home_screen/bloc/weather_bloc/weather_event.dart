part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherEventInit extends WeatherEvent {
  int locationId;
  DateTime date;
  WeatherEventInit({required this.locationId, required this.date});
}
