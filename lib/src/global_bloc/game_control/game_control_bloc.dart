import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:fly_dash/gen/assets.gen.dart';
import 'package:fly_dash/src/models/game_status.dart';
import 'package:fly_dash/src/utils/string_extension.dart';

part 'game_control_event.dart';

part 'game_control_state.dart';

class GameControlBloc extends Bloc<GameControlEvent, GameControlState> {
  GameControlBloc() : super(GameControlState()) {
    on<GameControlStatusChangedEvent>(_onGameControlStatusChangedEvent);
    on<GameControlGetScoreEvent>(_onGameControlGetScoreEvent);
  }

  _onGameControlStatusChangedEvent(
    GameControlStatusChangedEvent event,
    Emitter<GameControlState> emit,
  ) {
    if (event.status != GameStatus.playing) {
      emit(state.copyWith(status: event.status));
      return;
    } else {
      emit(state.copyWith(status: event.status, score: 0));
    }
  }

  _onGameControlGetScoreEvent(
    GameControlGetScoreEvent event,
    Emitter<GameControlState> emit,
  ) {
    if (state.status != GameStatus.playing) return;
    FlameAudio.play(Assets.audio.gameGetPoint.gamePath);
    emit(state.copyWith(score: state.score + 1));
  }
}
