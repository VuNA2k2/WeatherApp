part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationStateSuccess extends LocationState {
  List<Location> locations;
  Location currentLocation;
  LocationStateSuccess({required this.locations, required this.currentLocation});
}

class LocationStateChange extends LocationState {
  Location location;
  LocationStateChange({required this.location});
}

class LocationStateFail extends LocationState {}
