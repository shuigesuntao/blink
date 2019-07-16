import 'package:blink/common/net/base_exception.dart';
import 'package:blink/common/net/base_resp.dart';
import 'package:rxdart/rxdart.dart';

class BaseRepository{
  T convert<T>(BaseResp<T> t) {
    if (t.code != 0 || t.hasError) throw BaseException(t.code, t.msg);
    return t.data;
  }

  bool convertBool<T>(BaseResp<T> t) {
    if (t.code != 0 || t.hasError) throw BaseException(t.code, t.msg);
    return true;
  }
}