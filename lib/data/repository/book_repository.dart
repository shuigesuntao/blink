import 'package:blink/bean/book.dart';
import 'package:blink/common/net/base_resp.dart';
import 'package:blink/data/api/api.dart';
import 'package:blink/common/net/http_manager.dart';

import 'base_repository.dart';


class BookRepository extends BaseRepository{
  Future<List<Book>> getBooks(String q,int page) async {
    BaseResp<List> t = await HttpManager.getInstance().get(Api.TEST,queryParameters: {"q":q,"page":page});
    return getBookList(convert(t));
  }
}
