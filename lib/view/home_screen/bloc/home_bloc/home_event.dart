part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeEventInit extends HomeEvent {
  Location location;
  HomeEventInit({required this.location});
}

class HomeEventChange extends HomeEvent {
  Location location;
  HomeEventChange({required this.location});
}

