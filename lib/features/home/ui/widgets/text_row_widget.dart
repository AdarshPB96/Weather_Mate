import 'package:flutter/material.dart';
import 'package:weather_mate/constants/colors.dart';

class TextRow extends StatelessWidget {
  final String weatherDetail;
  final String? value;
  const TextRow({
    required this.weatherDetail,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 10, bottom: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Text(
                weatherDetail,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: tTextBlue),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Text(
                " - $value",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: tTextBlue),
              ),
            ),
          )
        ],
      ),
    );
  }
}
