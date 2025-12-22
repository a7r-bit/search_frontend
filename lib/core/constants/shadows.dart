import 'package:flutter/material.dart';

class AppShadows {
  static List<BoxShadow> elevated({
    int elevation = 2,
    Offset offset = const Offset(0, 4),
    double blur = 4,
  }) {
    return kElevationToShadow[elevation]!
        .map((shadow) => shadow.copyWith(offset: offset, blurRadius: blur))
        .toList();
  }
}
