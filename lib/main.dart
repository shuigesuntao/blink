import 'package:blink/ui/widget/error_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'common/util/sp_util.dart';
import 'base/bloc_provider.dart';
import 'bean/book.dart';
import 'blocs/main_bloc.dart';
import 'common/util/toast_util.dart';
import 'ui/widget/loading_page.dart';

SpUtil sp;
bool isHomeInit = true;
void main() async {
  sp = await SpUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(bloc: MainBloc(), child: MyHomePage()));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
//    bloc.init(context);
    if (isHomeInit) {
      isHomeInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.getBooks();
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("MVVM示例"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: bloc.bookStream,
              builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                }
                if (snapshot.hasError) {
                  ToastUtil.showToast(snapshot.error.toString());
                  return ErrorPage();
                }
                return Text(
                  "${snapshot.data}",
                  style: Theme.of(context).textTheme.display1,
                );
              }
            )
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: (){bloc.getBooks();},
        child: Icon(Icons.refresh),
      ),
    );
  }
}


