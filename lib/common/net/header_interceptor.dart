import 'package:blink/common/util/sp_util.dart';
import 'package:dio/dio.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    //本地取出token
    options.headers["token"] = SpUtil.getInstance().then((val) {
      val.getString("token");
    });
    return options;
  }
}
