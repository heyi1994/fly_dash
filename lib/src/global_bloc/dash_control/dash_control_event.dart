part of 'dash_control_bloc.dart';

sealed class DashControlEvent extends Equatable {
  const DashControlEvent();

  @override
  List<Object?> get props => [];
}

///开始上跳
final class DashJumpEvent extends DashControlEvent {}
