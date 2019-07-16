import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
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
}