import 'package:flutter/material.dart';

import 'colors.dart';

InputDecoration myInputDecoration({
  required String hintText,
  String? labelText,
  Widget? suffixIcon,
  String? suffixText,
}) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    suffixText: suffixText,
    suffixStyle: TextStyle(color: red),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 8,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: "02075D".toColor(),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 2,
        color: "02075D".toColor(),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 2,
        color: "02075D".toColor(),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 2,
        color: "02075D".toColor(),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 2,
        color: "02075D".toColor(),
      ),
    ),
    suffixIcon: suffixIcon,
  );
}

Widget customText({
  String? text,
  Color? textColor,
  double? fontSize,
  FontWeight? fontWeight,
  TextOverflow? textOverflow,
  int? maxLines,
  bool? softWrap,
  String? fontFamily,
  double? height,
  Paint? background,
  TextAlign? textAlign,
}) {
  return Text(
    text ?? '',
    overflow: textOverflow ?? TextOverflow.ellipsis,
    softWrap: softWrap ?? true,
    maxLines: maxLines ?? 1,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: fontSize ?? 12.0,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? 'Roboto-Medium',
        height: height ?? 1,
        background: background),
  );
}
