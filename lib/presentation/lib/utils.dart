import 'package:flutter/material.dart';

Widget buildPropertyTextWidget(String property, dynamic value) {
  return Center(
    child: RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 10.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: "$property :"),
          TextSpan(
            text: value.toString(),
            style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget buildLongPropertyTextWidget(String property, dynamic value) {
  // Adjust these values as per your requirement
  const double fontSize = 12.0;
  const double titleFontSize = 10.0;

  return Center(
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: titleFontSize,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: "$property: "),
          TextSpan(
            text: value.toString(),
            style: const TextStyle(
              fontSize: fontSize,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
