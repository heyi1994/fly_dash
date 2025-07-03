import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_dash/gen/assets.gen.dart';
import 'package:fly_dash/src/game/fly_bird_game.dart';
import 'package:fly_dash/src/utils/string_extension.dart';
import 'package:lottie/lottie.dart';

import '../consts/game_overlay.dart';
import '../global_bloc/dash_control/dash_control_bloc.dart';
import '../global_bloc/game_control/game_control_bloc.dart';
import '../overlay/game_over_overlay.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _loadAssets(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            return GameWidget(
              overlayBuilderMap: {
                overlayGameOver: (context, game) => const GameOverOverlay(),
              },
              game: FlyBirdGame(
                dashControlBloc: context.read<DashControlBloc>(),
                gameControlBloc: context.read<GameControlBloc>(),
              ),
            );
          }
          return Center(child: Lottie.asset(Assets.lottie.lottieLoading));
        },
      ),
    );
  }

  _loadAssets() async {
    await Flame.images.loadAllImages();
    await FlameAudio.audioCache.loadAll([
      Assets.audio.gameLoop.gamePath,
      Assets.audio.gameGetPoint.gamePath,
    ]);
    await FlameAudio.bgm.initialize();
    await FlameAudio.bgm.play(Assets.audio.gameLoop.gamePath);
  }
}
