import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum LoaderState { NoAction, Loading, Succeed, Failed, NoData }

class LoaderContainer extends StatefulWidget{

  final LoaderState loaderState;
  final Widget loadingView;
  final Widget errorView;
  final Widget emptyView;
  final Widget contentView;
  final Function onReload;

  LoaderContainer({
    Key key,
    @required this.contentView,
    this.loadingView,
    this.errorView,
    this.emptyView,
    @required this.loaderState,
    this.onReload,
  }) : super(key: key);

  @override
  State createState() => _LoaderContainerState();
}

class _LoaderContainerState extends State<LoaderContainer> {
  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    switch (widget.loaderState) {
      case LoaderState.Loading:
        currentWidget = widget.loadingView ?? _ClassicalLoadingView();
        break;
      case LoaderState.Failed:
        currentWidget = widget.errorView ?? _ClassicalErrorView(onReload: () => widget.onReload());
        break;
      case LoaderState.NoData:
        currentWidget = widget.emptyView ?? _ClassicalNoDataView();
        break;
      case LoaderState.Succeed:
      case LoaderState.NoAction:
        currentWidget = widget.contentView;
        break;
    }
    return currentWidget;
  }

}

class _ClassicalLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitFadingCircle(
          color: Colors.blueAccent,
          size: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            '正在拼命加载中...',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff999999),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ClassicalErrorView extends StatelessWidget {
  _ClassicalErrorView({@required this.onReload}) : super();

  final Function onReload;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/error.png',
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            '加载失败，请稍后点击重试',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff999999),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: RaisedButton(
            color: Colors.blueAccent,
            onPressed: onReload,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                '重新加载',
                style: TextStyle(color: Theme.of(context).buttonColor),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ClassicalNoDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/no_data.png',
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            '暂无相关数据 /(ㄒoㄒ)/~~',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff999999),
            ),
          ),
        ),
      ],
    ),
  );
}