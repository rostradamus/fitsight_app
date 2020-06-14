import 'package:flutter/material.dart';

class AppBarGradient extends LinearGradient {
  AppBarGradient({
    List<double> stops,
    GradientTransform transform,
  }) : super(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.red],
          tileMode: TileMode.clamp,
          stops: stops,
          transform: transform,
        );
}
