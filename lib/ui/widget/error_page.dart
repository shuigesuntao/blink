import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ErrorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: new Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 30.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: new Center(
              child: new Text('加载错误了哦~'),
            ),
          ),
        ],
      ),
    );
  }

}