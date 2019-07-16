
import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]) : super(props);
}

class ThemeChanged extends ThemeEvent {}