import 'package:flutter/material.dart';

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
