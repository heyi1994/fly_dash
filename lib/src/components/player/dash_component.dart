import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:fly_dash/gen/assets.gen.dart';
import 'package:fly_dash/src/components/pipeline/get_score_component.dart';
import 'package:fly_dash/src/components/pipeline/pipeline_component.dart';
import 'package:fly_dash/src/global_bloc/dash_control/dash_control_bloc.dart';
import 'package:fly_dash/src/global_bloc/game_control/game_control_bloc.dart';
import 'package:fly_dash/src/utils/string_extension.dart';

import '../../models/game_status.dart';

class DashComponent extends SpriteComponent
    with
        FlameBlocReader<GameControlBloc, GameControlState>,
        CollisionCallbacks,
        HasGameReference {
  DashComponent() : super(size: Vector2.all(80), anchor: Anchor.center);

  ///默认下拉的移动的距离
  final Vector2 _gravity = Vector2(0, 1400);

  ///垂直方向的移动距离
  Vector2 _vertical = Vector2(0, 0);

  ///跳转的距离
  final Vector2 _jump = Vector2(0, -500);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(Assets.images.dash.gamePath);
    await add(
      FlameBlocListener<DashControlBloc, DashControlState>(
        onNewState: (state) {
          if (state is DashControlJumpState) {
            jump();
          }
        },
      ),
    );
    add(
      FlameBlocListener<GameControlBloc, GameControlState>(
        listenWhen: (previous, current) => current.status == GameStatus.none,
        onNewState: (GameControlState state) {
          if (state.status == GameStatus.none) {
            position = Vector2.all(0);
            _vertical = Vector2(0, 0);
          }
        },
      ),
    );
    //碰撞类型为主动
    add(CircleHitbox()..collisionType = CollisionType.active);
  }

  @override
  void update(double dt) {
    if (bloc.state.status == GameStatus.playing) {
      _vertical += _gravity * dt;
      position += _vertical * dt;
      if (position.y > (game.camera.viewport.size.y / 2 + size.y / 2)) {
        bloc.add(GameControlStatusChangedEvent(status: GameStatus.gameOver));
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PipelineComponent && bloc.state.status == GameStatus.playing) {
      bloc.add(GameControlStatusChangedEvent(status: GameStatus.gameOver));
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is GetScoreComponent) {
      bloc.add(GameControlGetScoreEvent());
    }
    super.onCollisionEnd(other);
  }

  void jump() {
    _vertical = _jump;
  }
}
