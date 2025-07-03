import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:fly_dash/src/components/common_text_component.dart';

class TextButtonComponent extends ButtonComponent {
  final String text;
  late TextComponent _textComponent;

  TextButtonComponent({
    required this.text,
    super.onPressed,
    Vector2? position,
    Vector2? size,
  }) {
    this.position = position ?? Vector2.all(100);
    this.size = size ?? Vector2(150, 50);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 背景矩形
    final bg = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.blue,
    );
    _textComponent = CommonTextComponent(text: "重新开始");
    bg.add(_textComponent);

    button = bg;
  }
}
