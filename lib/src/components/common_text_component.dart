import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:fly_dash/gen/fonts.gen.dart';

class CommonTextComponent extends TextComponent {
  final Color? textColor;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;

  CommonTextComponent({
    required super.text,
    this.textColor,
    this.fontSize,
    this.letterSpacing,
    this.fontWeight,
    super.anchor,
    super.position,
    super.size,
    super.scale,
    super.angle,
  }) : super(
         textRenderer: TextPaint(
           style: TextStyle(
             color: textColor ?? Colors.white,
             fontSize: fontSize ?? 16,
             letterSpacing: letterSpacing,
             fontFamily: FontFamily.zCOOLKuaiLe,
             fontWeight: fontWeight,
           ),
         ),
       );
}
