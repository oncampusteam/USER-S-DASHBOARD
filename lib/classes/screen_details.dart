import 'package:flutter/material.dart';

class ScreenDetails {
  static double ScreenHeight = 0;
  static double ScreenWidth = 0;

  void screenDimensions(
      {required double screenWidth, required double screenHeight}) {
    ScreenHeight = screenHeight;
    ScreenWidth = screenWidth;
  }

  static double percentage(
      {required double percent, required String quantityToScale}) {
    double temp = (percent / 100) *
        (quantityToScale == "Width" ? ScreenWidth : ScreenHeight);
    debugPrint("Percentage of the dimension using: $temp");
    return temp;
  }
}
