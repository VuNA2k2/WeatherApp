import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/data/repository/locations_repository.dart';

import '../../../../model/location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc({required this.repository}) : super(LocationInitial()) {
    on<LocationEventInit>(
      _init
    );
    on<LocationEventChange>(
      _changeLocation,
    );
  }

  final LocationRepository repository;

  FutureOr<void> _init(LocationEventInit event, Emitter<LocationState> emit) async {
    try {
      final Response response = await repository.getLocations();
      if(response.statusCode == 200) {
        List<Location> locations = locationFromJson(response.data);
        emit(LocationStateSuccess(locations: locations, currentLocation: locations[0]));
      } else {
        emit(LocationStateFail());
      }
    } catch (e) {

    }
    // emit(LocationStateSuccess(locations: response.data))
  }

  FutureOr<void> _changeLocation(LocationEventChange event, Emitter<LocationState> emit) {
    emit(LocationStateChange(location: event.location));
  }
}
