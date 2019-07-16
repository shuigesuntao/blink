import 'package:blink/bean/book.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BookState extends Equatable {
  BookState([List props = const []]) : super(props);
}

class BookInit extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;
  final int currentPage;
  final bool isLoadMore;

  BookLoaded({@required this.books,this.isLoadMore = false,this.currentPage = 1}): super([books,isLoadMore,currentPage]);
}

class BookError extends BookState {
  final String msg;

  BookError({this.msg}):super([msg]);
}