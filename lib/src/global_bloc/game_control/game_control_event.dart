part of 'game_control_bloc.dart';

sealed class GameControlEvent extends Equatable {
  const GameControlEvent();

  @override
  List<Object?> get props => [];
}

final class GameControlStatusChangedEvent extends GameControlEvent {
  final GameStatus status;

  const GameControlStatusChangedEvent({required this.status});
}

///得分
final class GameControlGetScoreEvent extends GameControlEvent {}
