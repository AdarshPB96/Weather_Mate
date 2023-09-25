
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_mate/features/home/repos/current_weather_fetch.dart';

import 'package:weather_mate/features/home/models/current_weather_details.dart';
part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<CurrentWeatherFetchEvent>(currentWeatherFetchEvent);
  }


}
