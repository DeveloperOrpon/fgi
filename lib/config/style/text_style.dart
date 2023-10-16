import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static const String fontFamily = 'Rubik';

  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    fontSize: 35,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
  );

  static const TextStyle bodySm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    color: Colors.white
  );

  static const TextStyle bodyLg = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static const TextStyle boldstyle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
  );
  static const TextStyle drawerTextStyle = TextStyle(
    fontFamily: fontFamily,
    color: Colors.black54,
    fontSize: 16,
  );  static  TextStyle summeryTextStyle = GoogleFonts.notoSansDeseret(

    color: Colors.white,
    fontSize: 14,
    letterSpacing: 1.1,
    fontWeight: FontWeight.bold
  );

}
