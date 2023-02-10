part of 'location_bloc.dart';

abstract class LocationEvent {}

class LocationEventInit extends LocationEvent {

}

class LocationEventChange extends LocationEvent {
  Location location;
  LocationEventChange({required this.location});
}