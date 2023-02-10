import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/model/location.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEventInit>(
      _init,
    );
    on<HomeEventChange>(
      _changeLocation,
    );
  }

  FutureOr<void> _init(HomeEventInit event, Emitter<HomeState> emit) {
    emit(HomeStateSuccess(currentLocation: event.location));
  }



  FutureOr<void> _changeLocation(HomeEventChange event, Emitter<HomeState> emit) {
    emit(HomeStateSuccess(currentLocation: event.location));
  }
}
