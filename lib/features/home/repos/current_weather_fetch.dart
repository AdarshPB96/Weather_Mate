  import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mate/constants/api_strings.dart';
import 'package:weather_mate/features/home/bloc/home_bloc_bloc.dart';
import 'package:weather_mate/features/home/models/current_weather_details.dart';
import 'package:http/http.dart' as http;

FutureOr<void> currentWeatherFetchEvent(
      CurrentWeatherFetchEvent event, Emitter<HomeBlocState> emit) async {
    emit(LoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    final lat = pref.get("latitude");
    final lon = pref.get("longitude");
    CurrentWeatherModel currentWeatherDetails;
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);

        currentWeatherDetails = CurrentWeatherModel.froJson(result);
        emit(CurrentWeatherFetchedState(currentWeatherDetails));
      }
    } catch (e) {
      log(e.toString());
    }
  }