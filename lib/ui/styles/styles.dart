import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static Color appBackground = const Color(0xff1C208F);
  // static Color colorBlack = const Color(0xff1D252D);
  // static Color colorLemon = const Color(0xff14bfff);
  // static Color colorWhite = const Color(0xffFAFBFD);
  static Color colorLughtBlue = const Color(0xff506d85);

  //  insure_marts
  //  $,

  static Color appBackground1 = const Color(0xff03588c);
  // static Color colorWhite = const Color(0xffffffff);
  static Color appBackground2 = const Color(0xff023859);
  static Color colorLightgreen = const Color(0xff03a688);
  // static Color colorBlack = const Color(0xff222222);
  static Color colorDeepGreen = const Color(0xff038c7f);
  static Color colorNavGreen = const Color(0xff038c7f);
  static Color colorLemon = const Color(0xff6bffff);
  static Color colorLightBlue = const Color(0xff2269b3);
  static Color colorBoxBackground = const Color(0xffFAFAFA);
  static Color colorBoxBorder = const Color(0xffCCCCCC);
  static Color colorLightLemon = const Color(0xffB3E4DB);
  static Color colorDeepPink = const Color(0xffEA5B0C);
  static Color colorLightPink = const Color(0xffFDEFE7);
  static Color colorDeepGrey = const Color(0xff808080);
  static Color coloratm1 = const Color(0xff8688bc);
  static Color coloratm2 = const Color(0xff232558);
  static Color colorRed = const Color(0xffff0000);
  static Color appSecColor = Color(0xffe8ac33);

  static Color colorLightPurple = const Color(0xff6D77A2);
  static Color colorOrange = const Color(0xffF2994A);

  // static Color appCanvasLemonLight = const Color(0xff90DBDE);
  // static Color appBackground = const Color(0xffF5FCFF);
  // static Color colorBlack = const Color(0xff2C2929);

  // static Color colorPurple = const Color(0xff00156B);
  // static Color colorGrey = const Color(0xff797979);
  static Color red = Colors.red;

  static String brandon = 'Brandon';
  static String crossten = 'Crossten';
  String nothing = '';

  //
  static Color colorWhite = Colors.white;
  static Color colorBlack = const Color(0xff222222);
  static Color colorPurple = const Color(0xff03588c);
  // Color(0xff7B4397);
  static Color colorPurpleLight =
  //  const Color(0xff03588c);
  Color(0xff2269b3);
  // Color(0xff9F5DE2);
  static Color colorGreyLight = const Color(0xffdbd9d9);
  static Color colorGrey = const Color(0xff909090);
  static Color errorColor = Colors.red;

  static InputDecoration inputDec1 = InputDecoration(
    contentPadding: const EdgeInsets.all(8),
    fillColor: Styles.colorGrey.withOpacity(0.05),
    filled: true,
    labelStyle: GoogleFonts.nunito(
        color: Styles.colorGrey, fontWeight: FontWeight.w600, fontSize: 16),
    errorStyle: const TextStyle(
      color: Color(0xff222222),
    ),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff082485), width: 1.7)),
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Styles.colorBlack.withOpacity(0.2), width: 2),
    ),
    border: const OutlineInputBorder(),
    counterText: '',
  );

  void doNothing() {}
}
