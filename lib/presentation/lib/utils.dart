import 'package:flutter/material.dart';

// Define the color palette from the graphical charter
class AppColors {
  static const Color blue = Color(0xFF598979);
  static const Color lightGreen = Color(0xFF8AAC3E);
  static const Color teal = Color(0xFF7DAB9C);
  static const Color black = Color(0xFF1a1a18);
  static const Color beige = Color(0xFFF4F1E4);
  static const Color brown = Color(0xFF8B5500);
}

Widget buildPropertyTextWidget(String property, dynamic value) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 10.0,
          color: AppColors.black,
          fontFamily: 'Arial',
        ),
        children: <TextSpan>[
          TextSpan(
              text: "$property: ", style: TextStyle(color: AppColors.blue)),
          TextSpan(
            text: value.toString(),
            style: TextStyle(
                fontSize: 14.0,
                color: AppColors.lightGreen,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget buildLongPropertyTextWidget(String property, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 10.0,
          color: AppColors.black,
          fontFamily: 'Arial',
        ),
        children: <TextSpan>[
          TextSpan(
              text: "$property: ", style: TextStyle(color: AppColors.teal)),
          TextSpan(
            text: value.toString(),
            style: TextStyle(
              fontSize: 12.0,
              color: AppColors.lightGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
