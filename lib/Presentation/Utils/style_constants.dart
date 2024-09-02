import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StyleConstants {
  static  buttonBordersStyle(
          {required Color borderColor, required Color backgroundColor}) =>
      ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(8)));

  static submitButtonStyle(
          {required Color borderColor, required Color backgroundColor}) =>
      ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(8)));

  static titleStyle() => TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: Adaptive.sp(18));

  static buttonTextStyle()=> TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: Adaptive.sp(14));
  static normalStyle() => TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: Adaptive.sp(14));
}
