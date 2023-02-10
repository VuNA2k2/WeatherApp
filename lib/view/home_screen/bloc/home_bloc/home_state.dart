part of 'home_bloc.dart';

@immutable
abstract class HomeState {

}

class HomeInitial extends HomeState {}

class HomeStateSuccess extends HomeState {
  Location currentLocation;
  HomeStateSuccess({required this.currentLocation});
}

class HomeStateChange extends HomeState {
  Location selectLocation;
  HomeStateChange({required this.selectLocation});
}
