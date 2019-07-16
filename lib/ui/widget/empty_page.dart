
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
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

}