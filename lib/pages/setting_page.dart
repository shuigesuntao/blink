import 'package:blink/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('设置')),
      body: ListView(
        children: <Widget>[
          BlocBuilder(
            bloc: themeBloc,
            builder: (_, ThemeState state) {
              return ListTile(
                title: Text('切换主题'),
                isThreeLine: true,
                subtitle: Text('夜间模式'),
                trailing: Switch(
                  value: state.type == ThemeType.dark,
                  onChanged: (_) =>
                    themeBloc.dispatch(ThemeChanged()),
                ),
              );
            }),
        ],
      ),
    );
  }

}