// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mate/features/first_screen/first_screen.dart';
import 'package:weather_mate/features/home/ui/home_screen.dart';

class SplahScreen extends StatelessWidget {
  const SplahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tSize = MediaQuery.of(context).size;
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      
      final lat = pref.get("latitude");
      if(lat==null){
Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const FirstScreen()));
      }
      else{
 Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
          
    });
    return Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(
            height: tSize.height * 0.2,
          ),
          SizedBox(
              height: tSize.height * 0.3,
              child: LottieBuilder.asset(
                  "assets/animations/animation_splash.json")),
          const Text(
            "WeatherMate",
            style: TextStyle(fontSize: 40),
          )
        ]),
      ),
    );
  }
}
