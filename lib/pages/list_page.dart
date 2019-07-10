import 'package:blink/bean/book.dart';
import 'package:blink/blocs/main_bloc.dart';
import 'package:blink/ui/widget/loader_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  MainBloc _mainBloc = MainBloc();
  @override
  void initState() {
    super.initState();
    _mainBloc.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _mainBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BookList'),
        ),
        body: _bookList(),
        floatingActionButton: Consumer<MainBloc>(
          builder: (context, mainBloc, child) => FloatingActionButton(
            onPressed: mainBloc.getBooks,
            tooltip: 'Refresh',
            child: child,
          ),
          child: const Icon(Icons.refresh),
        )
      )
    );
  }

  Widget _bookList() {
    return Consumer<MainBloc>(
      builder: (context, mainBloc,_) => LoaderContainer(
        contentView: ListView.builder(
          itemCount: mainBloc.books == null ? 0 : mainBloc.books.length,
          itemBuilder: (context, index) {
            Book book = mainBloc.books[index];
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Image.network(
                    book.image,
                    width: 80,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        children: [
                          Text(
                            book.title ?? '',
                            maxLines: 1,
                            style: const TextStyle(color: Color(0xff826762), fontSize: 16.0),
                          ),
                          Text(
                            "${book.author[0]}/${book.publisher}/${book.price}",
                            style: const TextStyle(color: Color(0xff8e8e8e), fontSize: 12.0),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: Text(
                              book.summary,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Color(0xff8e8e8e), fontSize: 12.0),
                            ),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ));
          },
        ),
        loaderState: mainBloc.state,
        onReload: mainBloc.getBooks,
      )
    );
  }
}
