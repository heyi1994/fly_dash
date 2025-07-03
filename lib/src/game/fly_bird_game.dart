import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fly_dash/src/global_bloc/dash_control/dash_control_bloc.dart';
import 'package:fly_dash/src/models/game_status.dart';

import '../global_bloc/game_control/game_control_bloc.dart';
import 'fly_bird_world.dart';

class FlyBirdGame extends FlameGame<FlyBirdWorld>
    with TapDetector, KeyboardEvents ,HasCollisionDetection{
  final DashControlBloc dashControlBloc;
  final GameControlBloc gameControlBloc;

  FlyBirdGame({required this.dashControlBloc, required this.gameControlBloc})
    : super(
        world: FlyBirdWorld(
          dashControlBloc: dashControlBloc,
          gameControlBloc: gameControlBloc,
        ),
        camera: CameraComponent.withFixedResolution(width: 600, height: 1000),
      );

  @override
  FutureOr<void> onLoad() {
    ///将摄像机视口设置为最大视口
    camera.viewport = MaxViewport();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
    if (isSpace) {
      _startOrJump();
      return KeyEventResult.handled;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  _startOrJump() {
    if (gameControlBloc.state.status == GameStatus.none) {
      gameControlBloc.add(
        GameControlStatusChangedEvent(status: GameStatus.playing),
      );
    } else {
      dashControlBloc.add(DashJumpEvent());
    }
  }

  @override
  void onTap() {
    _startOrJump();
  }
}
