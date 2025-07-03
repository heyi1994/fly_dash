import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../../global_bloc/game_control/game_control_bloc.dart';

///放置在管道对中间的一条线，碰撞结束后，视为得分
class GetScoreComponent extends PositionComponent
    with FlameBlocReader<GameControlBloc, GameControlState> {
  final double gap;

  GetScoreComponent({this.gap = 300, super.position});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(1, gap);

    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }
}
