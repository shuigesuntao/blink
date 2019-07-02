class BaseResp<T> {
  int code;
  String msg;
  T data;
  bool hasError ;
  BaseResp(this.code, this.msg, this.data,{this.hasError});
}