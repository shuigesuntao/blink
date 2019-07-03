import 'package:blink/base/base_bolc.dart';
import 'package:blink/bean/book.dart';
import 'package:blink/data/repo.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BaseBloc {

  Repo repo = Repo();
  // ignore: close_sinks
  BehaviorSubject<List<Book>> _book = BehaviorSubject();

  Stream<List<Book>> get bookStream => _book.stream;

  void getBooks() {
    Observable.just(1).delay(Duration(seconds: 3))
      .listen((_) {
      repo.getBooks()
        .listen((books) => _book.add(books),
        onError: (e) => _book.addError(e.msg));
    });
  }

  @override
  void dispose() {
    _book.close();
  }

  @override
  void doInit(BuildContext context) {
    getBooks();
  }
}
