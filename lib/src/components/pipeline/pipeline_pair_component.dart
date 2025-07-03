import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:fly_dash/src/global_bloc/game_control/game_control_bloc.dart';

import '../../consts/game_consts.dart';
import '../../models/game_status.dart';
import 'get_score_component.dart';
import 'pipeline_component.dart';

///管道对
class PipelinePairComponent extends PositionComponent
    with FlameBlocListenable<GameControlBloc, GameControlState> {
  ///管道对中间的距离
  final double gap;

  ///管道对向左移动的速度
  final double speed;

  PipelinePairComponent({this.gap = 300, this.speed = 100,super.position});

  @override
  FutureOr<void> onLoad() {
    addAll([
      PipelineComponent(position: Vector2(0, -gap / 2), isFlip: true),
      PipelineComponent(position: Vector2(0, gap / 2)),
      GetScoreComponent(gap: gap, position: Vector2(pipelineWidth/2, -gap / 2)),
    ]);
  }

  @override
  void update(double dt) {
    switch (bloc.state.status) {
      case GameStatus.playing:
        position.x += -speed * dt;
        break;
      default:
    }
  }
}
