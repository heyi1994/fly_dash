import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../components/root_component.dart';
import '../global_bloc/dash_control/dash_control_bloc.dart';
import '../global_bloc/game_control/game_control_bloc.dart';

class FlyBirdWorld extends World {
  final DashControlBloc dashControlBloc;
  final GameControlBloc gameControlBloc;

  FlyBirdWorld({required this.dashControlBloc, required this.gameControlBloc});

  @override
  FutureOr<void> onLoad() async {
    //debugMode = true;
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<DashControlBloc, DashControlState>(
            create: () => dashControlBloc,
          ),
          FlameBlocProvider<GameControlBloc, GameControlState>(
            create: () => gameControlBloc,
          ),
        ],
        children: [RootComponent()],
      ),
    );
  }
}
