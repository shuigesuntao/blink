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
  State<StatefulWidget> createState() => BookListPageState();
}

class BookListPageState extends State<BookListPage>{
  final _textController = TextEditingController();
  final GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  final GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  final GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  BookBloc _bookBloc;

  @override
  void initState() {
    super.initState();
    _bookBloc = BlocProvider.of<BookBloc>(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onClearTapped() {
    _textController.text = '';
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
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.clear),
                        onTap: _onClearTapped,
                      ),
                      border: InputBorder.none,
                      hintText: '请输入关键字',
                    ),
                  ),
                )
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _bookBloc.dispatch(FetchBook(q:_textController.text,isRefresh: false));
                },
              )
            ],

          ),
          Expanded(
            child:  BlocBuilder(
              bloc: _bookBloc,
              builder: (context,state){
                if(state is BookLoading){
                  return LoadingPage();
                }
                if(state is BookEmpty){
                  return EmptyPage();
                }
                if(state is BookError){
                  return ErrorPage(
                    onReload:()=>_bookBloc.dispatch(FetchBook(q: _textController.text,isRefresh: false))
                  );
                }
                return RefreshLayout(
                  easyRefreshKey: _easyRefreshKey,
                  headerKey: _headerKey,
                  footerKey: _footerKey,
                  emptyWidget: EmptyPage(),
                  child: _buildList(state),
                  onRefresh: () async{
                    _bookBloc.dispatch(FetchBook(q: _textController.text));
                  },
                  loadMore: () async {
                    _bookBloc.dispatch(LoadMoreBook(q: _textController.text,page:
                    state is BookLoaded ? state.currentPage + 1 : 1));
                  }
                );
              }
            )
          )
        ],
      )
    );
  }

  Widget _buildList(BookState state){
    if(state is BookLoaded){
      if(state.isLoadMore){
        _easyRefreshKey.currentState.callLoadMoreFinish();
      }
      if(state.isRefresh){
        _easyRefreshKey.currentState.callRefreshFinish();
      }
      return ListView.builder(
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
