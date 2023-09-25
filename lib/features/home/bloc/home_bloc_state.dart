part of 'home_bloc_bloc.dart';

@immutable
abstract class HomeBlocState {}

class HomeBlocInitial extends HomeBlocState {}

class LoadingState extends HomeBlocState{}

class CurrentWeatherFetchedState extends HomeBlocState {
  final CurrentWeatherModel currentWeather;

  CurrentWeatherFetchedState(this.currentWeather);
}
