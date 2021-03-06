import 'package:flutter/material.dart';

class ThemeColors {
  static MColors of(BuildContext context) {
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    final mColors = MColors(platformBrightness);
    return mColors;
  }
}

class MColors {
  Color primary;
  Color statusColor;
  Color accentColor;
  Color borderColor;
  Color backgroundColor;
  Color backgroundColorElevation;
  Color backgroundField;
  Color greenCheck;
  Color fontPrimary;
  Color fontFeatured;
  Color fontSecondary;

  final Brightness brightness;

  MColors(this.brightness) {
    primary = brightness == Brightness.light ? HexColor("#010A53") : HexColor("#010A53");
    statusColor = brightness == Brightness.light ? HexColor("#010A53") : HexColor("#010A53");
    accentColor = brightness == Brightness.light ? HexColor("#4CD964") : HexColor("#4CD964");
    borderColor = brightness == Brightness.light ? HexColor("#000634") : HexColor("#FFFFFF");
    backgroundColor = brightness == Brightness.light ? HexColor("#FFFFFF") : HexColor("#121212");
    fontPrimary = brightness == Brightness.light ? HexColor("#000000") : HexColor("#FFFFFF");
    fontSecondary = brightness == Brightness.light ? HexColor("#010A53") : Colors.white;
    fontFeatured = brightness == Brightness.light ? HexColor("#00B2FF") : Colors.white;
    backgroundColorElevation = brightness == Brightness.light ? HexColor("#FFFFFF") : HexColor("#3B3B3B");
    backgroundField = brightness == Brightness.light ? HexColor("#F0F0F0") : HexColor("#F0F0F0");
    greenCheck = brightness == Brightness.light ? HexColor("#719B7F") : HexColor("#719B7F");
  }
}

// HexColor Converter
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
