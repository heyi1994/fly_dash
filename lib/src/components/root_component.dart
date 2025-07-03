import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/layout.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fly_dash/src/components/common_text_component.dart';
import 'package:fly_dash/src/consts/game_overlay.dart';
import 'package:fly_dash/src/global_bloc/game_control/game_control_bloc.dart';
import 'package:fly_dash/src/utils/screen_utils.dart';

import '../consts/game_consts.dart';
import '../models/game_status.dart';
import 'background/background_component.dart';
import 'pipeline/pipeline_pair_component.dart';
import 'player/dash_component.dart';

class RootComponent extends Component
    with
        HasGameReference,
        FlameBlocListenable<GameControlBloc, GameControlState> {
  CommonTextComponent? _tapToStart;
  CommonTextComponent? _title;

  PipelinePairComponent? _lastPipe;

  final Random _random = Random();

  CommonTextComponent? _scoreText;

  @override
  FutureOr<void> onLoad() async {
    await add(BackgroundComponent());
    await add(DashComponent());
    _buildPipes(fromX: game.camera.viewport.size.x / 2 + 50);
    await add(
      FlameBlocListener<GameControlBloc, GameControlState>(
        listenWhen: (previous, current) => previous.status != current.status,
        onNewState: (state) {
          switch (state.status) {
            case GameStatus.playing:
              _removeTapToStart();
              game.camera.viewport.add(
                _scoreText = CommonTextComponent(
                  position: Vector2(10, statusBarHeight + 2),
                  text: "分数 0",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  fontSize: 24,
                  textColor: Colors.yellow,
                ),
              );
              break;
            case GameStatus.pause:
              break;
            case GameStatus.gameOver:
              game.overlays.add(overlayGameOver);
              break;
            case GameStatus.none:
              _addTapToStart();
              if (_scoreText != null) {
                game.camera.viewport.remove(_scoreText!);
              }
              game.overlays.remove(overlayGameOver);
              final pipelines = children.whereType<PipelinePairComponent>();
              removeAll(pipelines);
              _buildPipes(fromX: game.camera.viewport.size.x / 2 + 50);
              break;
          }
        },
      ),
    );
    _addTapToStart();
  }

  @override
  void onNewState(GameControlState state) {
    _scoreText?.text = "分数 ${state.score}";
  }

  @override
  bool listenWhen(GameControlState previousState, GameControlState newState) =>
      previousState.score != newState.score;

  _addTapToStart() {
    if (_tapToStart != null) return;
    _title = CommonTextComponent(
      text: "FLY DASH",
      letterSpacing: 2,
      fontSize: 60,
      anchor: Anchor.center,
      textColor: Colors.blue.shade600,
      fontWeight: FontWeight.bold,
      position: Vector2(0, -game.camera.viewport.size.y / 4),
    );

    _tapToStart = CommonTextComponent(
      text: "点击开始",
      letterSpacing: 10,
      fontSize: 30,
      anchor: Anchor.center,
      fontWeight: FontWeight.bold,
      position: Vector2(0, game.camera.viewport.size.y / 4),
    );
    _tapToStart?.add(
      ScaleEffect.to(
        Vector2.all(0.8),
        EffectController(infinite: true, duration: 0.5, reverseDuration: 0.5),
      ),
    );
    add(_tapToStart!);
    add(_title!);
  }

  _removeTapToStart() {
    if (_tapToStart == null) return;
    remove(_tapToStart!);
    remove(_title!);
    _tapToStart = null;
    _title = null;
  }

  ///批量构建管道对
  ///
  /// - [count] 管道对数量
  /// - [fromX] 管道对开始位置
  /// - [distance] 管道对之间的距离
  _buildPipes({int count = 5, double fromX = 0, double distance = 400}) {
    for (var i = 0; i < count; i++) {
      const area = 600;
      final y = (_random.nextDouble() * area) - area / 2;
      final pair = PipelinePairComponent(
        position: Vector2(fromX + i * distance, y),
      );
      add(pair);
      if (i == count - 1) {
        _lastPipe = pair;
      }
    }
  }

  @override
  void update(double dt) {
    //无限生成
    if (_lastPipe != null) {
      //当最后一个管道距离右侧距离大于distance/2 批量生成一部分
      if (game.camera.viewport.size.x / 2 - _lastPipe!.x > 400 / 2) {
        _buildPipes(fromX: _lastPipe!.x + 400);
      }
    }
    _removePipelinePair();
  }

  ///移动到相机视角外部就移除管道对
  _removePipelinePair() {
    final child = children.whereType<PipelinePairComponent>();
    for (var element in child) {
      if (element.x < -game.camera.viewport.size.x / 2 - pipelineWidth / 2) {
        remove(element);
      }
    }
  }
}
