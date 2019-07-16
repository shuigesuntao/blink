

import 'theme_bloc_event.dart';
import 'theme_bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'theme_type.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  @override
  ThemeState get initialState => ThemeState(
    type: ThemeType.light,
  );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChanged) {
      yield ThemeState(
        type: currentState.type == ThemeType.light? ThemeType.dark :ThemeType.light
      );
    }
  }
}
