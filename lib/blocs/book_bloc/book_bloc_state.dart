import 'package:blink/bean/book.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BookState extends Equatable {
  BookState([List props = const []]) : super(props);
}

class BookLoading extends BookState {}

class BookEmpty extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;
  final int currentPage;
  final bool isLoadMore;
  final bool isRefresh;

  BookLoaded({
    @required this.books,
    this.isLoadMore = false,
    this.isRefresh = false,
    this.currentPage = 1
  }): super([books,isLoadMore,isRefresh,currentPage]);
}

class BookError extends BookState {
  final String msg;

  BookError({this.msg}):super([msg]);
}