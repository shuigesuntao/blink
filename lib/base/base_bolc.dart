
import 'package:blink/data/repo.dart';
import 'package:flutter/widgets.dart';
import 'package:blink/ui/widget/loader_container.dart' as LoaderStater;

abstract class BaseBloc with ChangeNotifier {


  Repo _repo;

  Repo get repo => getRepo();

  LoaderStater.LoaderState state = LoaderStater.LoaderState.Loading;

  Repo getRepo(){
    if(_repo == null){
      _repo = Repo();
    }
    return _repo;
  }


  @protected
  Future onRefresh(){

  }

  @protected
  Future onLoadMore(){

  }

  void dispose();


}
