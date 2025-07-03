import 'package:flutter/material.dart';

class CommonTextWidget extends StatelessWidget {
  final String data;
  final Color? textColor;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;

  const CommonTextWidget({
    super.key,
    required this.data,
    this.textColor,
    this.fontSize,
    this.letterSpacing,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: textColor ?? Colors.white,
        fontSize: fontSize ?? 26,
        letterSpacing: letterSpacing ?? 10,
        fontWeight: fontWeight ,
      ),
    );
  }
}
