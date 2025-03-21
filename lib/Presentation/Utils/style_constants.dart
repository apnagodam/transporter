import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Presentation/Utils/color_constants.dart';

class StyleConstants {
  static buttonBordersStyle(
          {required Color borderColor, required Color backgroundColor}) =>
      ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(8)));

  // static submitButtonStyle({Color? borderColor, Color? backgroundColor}) =>
  //     ElevatedButton.styleFrom(
  //         backgroundColor: backgroundColor,
  //         shape: RoundedRectangleBorder(
  //             side: BorderSide(color: borderColor),
  //             borderRadius: BorderRadius.circular(8)));
  static submitButtonStyle({Color? borderColor, Color? backgroundColor}) =>
      ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorConstants.secondaryColorWSP,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor ?? ColorConstants.secondaryColorWSP),
              borderRadius: BorderRadius.circular(8)));

  static titleStyle() => TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: Adaptive.sp(18));

  static buttonTextStyle() => TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: Adaptive.sp(14));
  static normalStyle() => TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: Adaptive.sp(14));
  static Googleprofile() => GoogleFonts.aBeeZee(
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontSize: Adaptive.sp(14));
  static GoogleprofileTextFeild() => GoogleFonts.aBeeZee(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: Adaptive.sp(14));
}
