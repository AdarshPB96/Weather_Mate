import 'dart:developer';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mate/features/home/repos/get_lat_lon.dart';
import 'package:weather_mate/features/home/ui/home_screen.dart';

class LocationAlertDialog extends StatefulWidget {
  const LocationAlertDialog({super.key});

  @override
  State<LocationAlertDialog> createState() => _LocationAlertDialogState();
}

class _LocationAlertDialogState extends State<LocationAlertDialog> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  double? latitude;
  double? longitude;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CSCPicker(
            showCities: true,
            showStates: true,
            dropdownDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            disabledDropdownDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            onCountryChanged: (value) {
              setState(() {
                countryValue = value.toString();
              });
            },
            onStateChanged: (value) {
              setState(() {
                stateValue = value.toString();
              });
            },
            onCityChanged: (value) {
              setState(() {
                cityValue = value.toString();
              });
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
            child: ElevatedButton(
                onPressed: () async {
                  await getLatAndLon(
                      city: cityValue, state: stateValue, contry: countryValue);
                  final SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  log(pref.getDouble("latitude").toString());
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                },
                child: const Text("Get"))),
        const SizedBox(
          height: 50,
        ),
        Center(
            child: IconButton(
                onPressed: () async {
                  try {
                    LocationPermission permission =
                        await Geolocator.requestPermission();
                    if (permission == LocationPermission.denied) {
                      return Future.error('Location services are disabled.');
                    } else {
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      final SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setDouble("latitude", position.latitude);
                      pref.setDouble("longitude", position.longitude);
                      log(pref.get("longitude").toString());
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                },
                icon: const Icon(Icons.location_on)))
      ],
    );
  }
}
