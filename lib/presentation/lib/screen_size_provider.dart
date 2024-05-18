import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final screenSizeProvider =
    Provider.family<ScreenSize, BuildContext>((ref, context) {
  double screenWidth =
      MediaQuery.of(context).size.width; // Adjust this line accordingly.

  if (screenWidth < 400) {
    return ScreenSize.small;
  } else if (screenWidth < 600) {
    return ScreenSize.medium;
  } else {
    return ScreenSize.large;
  }
});

enum ScreenSize { small, medium, large }
