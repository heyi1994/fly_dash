part of 'game_control_bloc.dart';

final class GameControlState extends Equatable {
  ///当前的分数
  final int score;

  ///当前游戏状态
  final GameStatus status;

  const GameControlState({this.score = 0, this.status = GameStatus.none});

  GameControlState copyWith({int? score, GameStatus? status}) {
    return GameControlState(
      score: score ?? this.score,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [score, status];
}
