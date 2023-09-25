import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_mate/features/home/ui/widgets/select_place_alertdialog.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset(
            "assets/animations/snowfall.json",
          ),
          const Text(
            "WeatherMate",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 30,
          ),
          IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LocationAlertDialog();
                  },
                );
              },
              icon: const Icon(
                Icons.arrow_right_alt_outlined,
                size: 50,
              ))
        ],
      ),
    );
  }
}
