import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Padding paddingAll(double value, {Key? key}) =>
      Padding(padding: EdgeInsets.all(value), key: key, child: this);

  Padding paddingOnly({
    Key? key,
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    ),
    key: key,
    child: this,
  );

  Padding paddingSymmetric({
    Key? key,
    double vertical = 0,
    double horizontal = 0,
  }) => Padding(
    padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
    key: key,
    child: this,
  );
}
