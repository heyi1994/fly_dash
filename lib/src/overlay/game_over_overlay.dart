import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_dash/src/utils/padding_extension.dart';
import 'package:fly_dash/src/widget/common_text_widget.dart';

import '../global_bloc/game_control/game_control_bloc.dart';
import '../models/game_status.dart';

class GameOverOverlay extends StatefulWidget {
  const GameOverOverlay({super.key});

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      color: Colors.black.withValues(alpha: 0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonTextWidget(
            data: "游戏结束",
            fontSize: 38,
            fontWeight: FontWeight.bold,
            textColor: Colors.amber,
          ),
          CommonTextWidget(
            letterSpacing: 2,
            data: "最终得分 ${context.read<GameControlBloc>().state.score}",
            fontSize: 24,
          ).paddingOnly(top: 20),
          FilledButton(
            child: CommonTextWidget(
              data: "重新开始",
              fontSize: 18,
              letterSpacing: 4,
            ),
            onPressed: () {
              context.read<GameControlBloc>().add(
                const GameControlStatusChangedEvent(status: GameStatus.none),
              );
            },
          ).paddingOnly(top: 20),
        ],
      ),
    );
  }
}
