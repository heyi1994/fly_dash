import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fly_dash/gen/assets.gen.dart';
import 'package:fly_dash/src/utils/string_extension.dart';

import '../../consts/game_consts.dart';

///管道精灵
class PipelineComponent extends SpriteComponent {
  ///是否将管道垂直翻转
  final bool isFlip;

  PipelineComponent({this.isFlip = false, required super.position});

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(Assets.images.pipe.gamePath);
    anchor = Anchor.topCenter;

    ///等比例缩放
    final ratio = sprite!.srcSize.y / sprite!.srcSize.x;
    const width = pipelineWidth;
    size = Vector2(width, width * ratio);

    final hitbox = RectangleHitbox()..collisionType = CollisionType.passive;

    ///垂直旋转
    if (isFlip) {
      angle = pi;
    }

    add(hitbox);
  }
}
