import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFF4D4861);
final Color secondaryColor = Color(0xFF9A98B5);

final Color purple1 = Color(0xFF8565c4);
final Color purple2 = Color(0xFF9477cb);
final Color purple3 = Color(0xFFa28ad2);
final Color purple4 = Color(0xFFb19cd9);
final Color purple5 = Color(0xFFc0aee0);

final myTextTheme = TextTheme(
  headline1: GoogleFonts.roboto(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.roboto(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.roboto(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.roboto(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.roboto(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.15),
  subtitle1: GoogleFonts.montserrat(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.montserrat(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.montserrat(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.montserrat(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
