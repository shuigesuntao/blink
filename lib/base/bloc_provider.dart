import 'package:flutter/material.dart';

import 'base_bolc.dart';


class BlocProvider<T extends BaseBloc> extends StatefulWidget{
  final T bloc;
  final Widget child;
  final bool userDispose;

  BlocProvider({
    Key key,
    @required this.bloc,
    @required this.child,
    this.userDispose: true,
  }) : super(key: key);

  static T of<T extends BaseBloc>(BuildContext context){
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;

  @override
  State<StatefulWidget> createState() {
    return _BlocProviderState();
  }
}

class _BlocProviderState extends State<BlocProvider>{
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    if (widget.userDispose) widget.bloc.dispose();
    super.dispose();
  }
}