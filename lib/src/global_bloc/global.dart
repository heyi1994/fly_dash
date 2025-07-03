import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fly_dash/src/global_bloc/dash_control/dash_control_bloc.dart';

import 'game_control/game_control_bloc.dart';

final globalBloc = [
  BlocProvider<DashControlBloc>(create: (context) => DashControlBloc()),
  BlocProvider<GameControlBloc>(create: (context) => GameControlBloc()),
];
