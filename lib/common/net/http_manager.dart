import 'package:blink/common/util/connect_util.dart';
import 'package:dio/dio.dart';
import 'base_resp.dart';
import 'package:blink/common/config.dart';
import 'package:rxdart/rxdart.dart';
import 'header_interceptor.dart';

class Method {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String head = "HEAD";
  static const String delete = "DELETE";
  static const String patch = "PATCH";
}

class HttpManager {
  static HttpManager _instance;
  static Dio _dio;
  static Map<String, dynamic> _headers;

  HttpManager() {
    _dio = Dio(BaseOptions(
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
      baseUrl: Config.BASE_URL
    ));
    _dio.interceptors.add(HeaderInterceptor());
    _dio.interceptors.add(LogInterceptor(request: false, responseBody: true, responseHeader: false));
  }

  static HttpManager getInstance() {
    if (_instance == null) {
      _instance = HttpManager();
    }
    return _instance;
  }

  Dio getDio() {
    return _dio;
  }

  static Future<BaseResp<T>> request<T>(String path,
      {String method,
      data,
      Map<String, dynamic> headers,
      Options options,
      CancelToken cancelToken}) async {
    Options op = _checkOptions(method, options);
    _headers = Map<String, dynamic>();
    if (headers != null) {
      _headers.addAll(headers);
    }
    op.headers = _headers;
    Response response;
    if (await ConnectUtil.isConnected()) {
      try {
        response = await _dio.request(path,
            data: data, options: op, cancelToken: cancelToken);
      } on DioError catch (e) {
        int code;
        String msg = "网络异常";
        if (e.type == DioErrorType.CONNECT_TIMEOUT ||
            e.type == DioErrorType.RECEIVE_TIMEOUT) {
          code = 25;
          msg = "请求超时,请稍后再试";
        } else if (e.type == DioErrorType.RESPONSE) {
          code = e.response.statusCode;
          switch (code) {
            case 500:
              msg = "服务器发生错误";
              break;
            case 404:
              msg = "请求地址不存在";
              break;
            case 403:
              msg = "请求被服务器拒绝";
              break;
            case 307:
              msg = "请求被重定向到其他页面";
              break;
          }
        } else {
          code = 26;
          msg = e.message;
        }
        return BaseResp(code, msg, null, hasError: true);
      }
      return BaseResp(
          response.data["code"], response.data["msg"], response.data["data"]);
    } else {
      //无网络
      return BaseResp(24, "暂无网络", null, hasError: true);
    }
  }

  static Options _checkOptions(String method, Options options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Observable<BaseResp> post(String path, data) =>
      Observable.fromFuture(request(path, method: Method.post, data: data))
          .asBroadcastStream();

  Observable<BaseResp> get(String path) =>
      Observable.fromFuture(request(path, method: Method.get))
          .asBroadcastStream();

  Future<BaseResp> getF(String path) => request(path, method: Method.get);

}
