import 'package:blink/base/base_bolc.dart';
import 'package:blink/bean/book.dart';
import 'package:blink/common/net/http_manager.dart';
import 'package:blink/common/util/toast_util.dart';
import 'package:blink/data/api.dart';
import 'package:blink/data/repo.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:blink/ui/widget/loader_container.dart' as LoaderStater;

class MainBloc extends BaseBloc {
  List<Book> _books;

  List<Book> get books => _books;

  void getBooks() async {
    repo.getBooks().listen((books) {
      _books = books;
      if(_books == null || _books.isEmpty){
        state = LoaderStater.LoaderState.NoData;
      }else{
        state = LoaderStater.LoaderState.Succeed;
      }
      notifyListeners();
    }, onError: (e) {
      state = LoaderStater.LoaderState.Failed;
      notifyListeners();
      ToastUtil.showToast(e.msg);
    });
  }
}
