import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:fly_dash/src/game/fly_bird_game.dart';
import 'package:fly_dash/src/global_bloc/game_control/game_control_bloc.dart';
import 'package:fly_dash/src/models/game_status.dart';
import 'package:fly_dash/src/utils/string_extension.dart';

import '../../../gen/assets.gen.dart';

///背景视差动画
class BackgroundComponent extends ParallaxComponent<FlyBirdGame>
    with FlameBlocReader<GameControlBloc, GameControlState> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    parallax = await game.loadParallax(
      [
        ParallaxImageData(Assets.images.background.layer1Sky.gamePath),
        ParallaxImageData(Assets.images.background.layer2Clouds.gamePath),
        ParallaxImageData(Assets.images.background.layer3Clouds.gamePath),
        ParallaxImageData(Assets.images.background.layer4Clouds.gamePath),
        ParallaxImageData(Assets.images.background.layer5HugeClouds.gamePath),
        ParallaxImageData(Assets.images.background.layer6Bushes.gamePath),
        ParallaxImageData(Assets.images.background.layer7Bushes.gamePath),
      ],
      baseVelocity: Vector2(1, 0),
      velocityMultiplierDelta: Vector2(1.8, 0),
    );
  }

  @override
  void update(double dt) {
    if (bloc.state.status != GameStatus.gameOver) {
      super.update(dt);
    }
  }
}
