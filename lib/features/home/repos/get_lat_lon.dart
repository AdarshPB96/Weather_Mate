
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
Future<void> getLatAndLon(
    {required city, required state, required contry}) async {
  var url = Uri.parse(
      "https://api.openweathermap.org/geo/1.0/direct?q= $city,$state,$contry&limit=5&appid=5d379042c5eb234798177572d79cd649");
  final response = await http.get(url);
  try {
    if (response.statusCode == 200) {
      // print("..........................successs");
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.isNotEmpty) {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setDouble("latitude", jsonResponse[0]["lat"]);
        pref.setDouble("longitude", jsonResponse[0]["lon"]);
      }
    }
  } catch (e) {
    log(e.toString());
  }
}
