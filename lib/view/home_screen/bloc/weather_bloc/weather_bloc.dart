import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/weather_repository.dart';
import '../../../../model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.repository}) : super(WeatherInitial()) {
    on<WeatherEventInit>(
      _init,
    );
  }

  final WeatherRepository repository;
  FutureOr<void> _init(WeatherEventInit event, Emitter<WeatherState> emit) async {
    try {
      final Response response = await repository.getWeatherByLocationAtDate(locationId: event.locationId, date: event.date);
      if(response.statusCode == 200) {
        Weather weather = Weather.fromJson(response.data);
        List<Weather> listWeatherOnWeek = [];
        for(int i = 0; i < 7; i ++) {
          DateTime dateTime = event.date.add(Duration(days: i));
          final Response responseX = await repository.getWeatherByLocationAtDate(locationId: event.locationId, date: dateTime);
          if(responseX.statusCode==200) {
            listWeatherOnWeek.add(Weather.fromJson(responseX.data));
          }
        }
        emit(WeatherStateSuccess(weather: weather, listWeatherOnWeek: listWeatherOnWeek));
      } else {
        emit(WeatherStateFail());
      }
    } catch (e) {

    }
  }
}
