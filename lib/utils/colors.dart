import 'package:flutter/material.dart';

const FontWeight fwnormal = FontWeight.normal;
const FontWeight fwbold = FontWeight.bold;
const FontWeight fw900 = FontWeight.w900;
const FontWeight fw800 = FontWeight.w800;
const FontWeight fw700 = FontWeight.w700;
const FontWeight fw600 = FontWeight.w600;
const FontWeight fw500 = FontWeight.w500;
const FontWeight fw400 = FontWeight.w400;
const FontWeight fw300 = FontWeight.w300;
const FontWeight fw200 = FontWeight.w200;
const FontWeight fw100 = FontWeight.w100;

Color primaryColor = "02075D".toColor();
const lightgrey = Color(0xFFD1D0D0);
const kThirdColor = Color(0xff003B71);
const white = Color(0xFFFFFFFF);
const border = Color(0xFFDBDBDB);
const Color lightBlack = Colors.black54;
const Color activeColor = Color(0xff22E11E);
const Color black = Colors.black;
const Color red = Colors.red;
const Color grey = Colors.grey;
const Color loginButtonColor = Color(0xff01e0ff);
const Color lightWhite = Color(0xfffcf2f2);
const Color green = Color(0xff336600);
const Color lightGreen = Color(0xFF2ED62E);
const Color grayColor = Color(0xFF6B7278);
const Color lightBlackBoldColor = Color(0xFF6B7278);

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
