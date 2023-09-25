
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mate/constants/colors.dart';
import 'package:weather_mate/features/home/bloc/home_bloc_bloc.dart';
import 'package:weather_mate/features/home/ui/widgets/select_place_alertdialog.dart';
import 'package:weather_mate/features/home/ui/widgets/text_row_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBlocBloc homeBloc = HomeBlocBloc();
  @override
  void initState() {
    homeBloc.add(CurrentWeatherFetchEvent());
    super.initState();
  }

  Future checkLocationData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final lat = pref.get("latitude");
    final long = pref.get("longitude");
    if (lat == null || long == null) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tSize = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocConsumer<HomeBlocBloc, HomeBlocState>(
        bloc: homeBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadingState:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case CurrentWeatherFetchedState:
              final successState = state as CurrentWeatherFetchedState;

              return Scaffold(
                backgroundColor: Color.fromARGB(255, 116, 185, 160),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              successState.currentWeather.place,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: tTextBlue),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            weatherCardTopText(
                                successState.currentWeather.main),
                            const SizedBox(
                              height: 20,
                            ),
                            weatherCardTopText(
                                "${successState.currentWeather.temperature.toStringAsFixed(2)}\u2103"),
                            const SizedBox(
                              height: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 105, 209, 219),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextRow(
                                      weatherDetail: "Temp",
                                      value:
                                          "${successState.currentWeather.temperature.toStringAsFixed(2)}\u2103",
                                    ),
                                    TextRow(
                                        weatherDetail: "FeelsLike",
                                        value:
                                            "${successState.currentWeather.feelsLike.toStringAsFixed(2)}\u2103"),
                                    TextRow(
                                        weatherDetail: "MinTemp",
                                        value:
                                            "${successState.currentWeather.minTemp.toStringAsFixed(2)}\u2103"),
                                    TextRow(
                                        weatherDetail: "MaxTemp",
                                        value:
                                            "${successState.currentWeather.maxTemp.toStringAsFixed(2)}\u2103"),
                                    TextRow(
                                        weatherDetail: "Pressure",
                                        value: successState
                                            .currentWeather.pressure
                                            .toString()),
                                    TextRow(
                                        weatherDetail: "Visibility",
                                        value: successState
                                            .currentWeather.visibility
                                            .toString()),
                                    TextRow(
                                        weatherDetail: "WindSpeed",
                                        value: successState
                                            .currentWeather.windSpeed
                                            .toString())
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          top: tSize.height * 0.06,
                          left: tSize.width * 0.2,
                          child: Lottie.asset(
                              "assets/animations/animation_lmyeuue3.json",
                              height: tSize.height * 0.4,
                              fit: BoxFit.contain),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const LocationAlertDialog();
                      },
                    );
                  },
                  child: const Icon(Icons.location_pin),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Center weatherCardTopText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 27, fontWeight: FontWeight.bold, color: tTextBlue),
      ),
    );
  }
}
