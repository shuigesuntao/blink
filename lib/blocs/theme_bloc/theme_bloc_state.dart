import 'package:blink/blocs/theme_bloc/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeType type;

  ThemeState({@required this.type})
    : assert(type != null), super([type]);
}