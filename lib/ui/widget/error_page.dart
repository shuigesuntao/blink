import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget{
  final Function onReload;
  ErrorPage({@required this.onReload,Key key}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/error.jpg',
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '加载失败，请稍后点击重试',
              style: TextStyle(
                fontSize: 16,
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

}