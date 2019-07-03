import 'package:blink/bean/book.dart';
import 'package:blink/data/api.dart';
import 'package:blink/common/net/base_exception.dart';
import 'package:blink/common/net/base_resp.dart';
import 'package:blink/common/net/http_manager.dart';
import 'package:rxdart/rxdart.dart';


class Repo {
  Observable<List<Book>> getBooks() {
    return HttpManager.getInstance()
        .get(Api.TEST)
        .flatMap((t) => convert(t))
        .flatMap((t) => Observable.just(getBookList(t)));
  }

  Stream<T> convert<T>(BaseResp<T> t) {
    if (t.code != 0 || t.hasError) return Observable.error(BaseException(t.code, t.msg));
    return t.data == null ? Observable.empty() : Observable.just(t.data);
  }
}
