import 'package:flutter/material.dart';

class ArabicTextStyle extends TextStyle {
  const ArabicTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) : super(
          fontFamily: 'Mirza',
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
        );

  static TextStyle mirza({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return ArabicTextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}
