part of 'dash_control_bloc.dart';

sealed class DashControlState extends Equatable {
  const DashControlState();
  @override
  List<Object> get props => [];
}

final class DashControlInitial extends DashControlState {

}


final class DashControlJumpState extends DashControlState {
  final int tag;
  const DashControlJumpState(this.tag);
  @override
  List<Object> get props => [tag];
}