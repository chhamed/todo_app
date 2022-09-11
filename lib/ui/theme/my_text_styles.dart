import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyTextStyles {
  static TextStyle headline1 = TextStyle(
    fontSize: 20.sp.clamp(30, 35),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static TextStyle headline2 = TextStyle(
    fontSize: 14.sp.clamp(20, 24),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static TextStyle hintStyle = TextStyle(
      fontSize: 12.sp.clamp(16, 20),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      color: Colors.grey);

  static TextStyle subhead = TextStyle(
    fontSize: 13.sp.clamp(16, 20),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static TextStyle body = TextStyle(
    fontSize: 12.sp.clamp(14, 16),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 13.sp.clamp(14, 18),
    fontFamily: 'Poppins',
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
}
