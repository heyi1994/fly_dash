import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dash_control_event.dart';

part 'dash_control_state.dart';

class DashControlBloc extends Bloc<DashControlEvent, DashControlState> {
  DashControlBloc() : super(DashControlInitial()) {
    on<DashJumpEvent>(_onDashJumpEvent);
  }

  _onDashJumpEvent(DashJumpEvent event, Emitter<DashControlState> emit) {
    emit(DashControlJumpState(DateTime.now().microsecondsSinceEpoch));
  }
}
