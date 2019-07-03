
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  bool _isFirst = true;

  bool get isFirst => _isFirst;

  void init(BuildContext context) {
    if (_isFirst) {
      _isFirst = false;
      doInit(context);
    }
  }

  @protected
  void doInit(BuildContext context);

  @protected
  Future onRefresh(){

  }

  @protected
  Future onLoadMore(){

  }

  void dispose();


}
