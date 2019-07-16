import 'package:blink/bean/book.dart';
import 'package:blink/blocs/blocs.dart';
import 'package:blink/pages/setting_page.dart';
import 'package:blink/ui/widget/refrsh_layout.dart';
import 'package:blink/ui/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class BookListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  BookBloc _bookBloc;

  @override
  void initState() {
    super.initState();
    _bookBloc = BlocProvider.of<BookBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('书籍列表'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: _bookBloc,
        builder: (context,state){
          if(state is BookError){
            return ErrorPage(
              onReload:()=>_bookBloc.dispatch(FetchBook(q: "郭敬明"))
            );
          }
          return RefreshLayout(
            easyRefreshKey: _easyRefreshKey,
            headerKey: _headerKey,
            footerKey: _footerKey,
            child: _buildList(state),
            onRefresh: () async{
              _bookBloc.dispatch(FetchBook(q: "郭敬明"));
            },
            loadMore: () async {
              _bookBloc.dispatch(LoadMoreBook(q: "郭敬明",page:
              state is BookLoaded ? state.currentPage + 1 : 1));
            }
          );
        }
      )
    );
  }

  // ignore: missing_return
  Widget _buildList(BookState state){
    if(state is BookLoaded){
      state.isLoadMore
        ? _easyRefreshKey.currentState.callLoadMoreFinish()
        : _easyRefreshKey.currentState.callRefreshFinish();
      return state.books.isEmpty
        ? EmptyPage()
        : ListView.builder(
            itemCount: state.books.length,
            itemBuilder: (context, index) {
          return BookItem(book:state.books[index]);
        },
      );
    }
    return Container();
  }
}

class BookItem extends StatelessWidget {

  final Book book;

  const BookItem({@required this.book,Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
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
                    "${book.author[0]}/${book.publisher??""}/${book.price}",
                    style: const TextStyle(color: Color(0xff8e8e8e), fontSize: 12.0),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      book.summary??"",
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
  }
}
