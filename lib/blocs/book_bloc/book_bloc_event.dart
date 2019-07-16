import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BookEvent extends Equatable {
  BookEvent([List props = const []]) : super(props);
}

class FetchBook extends BookEvent {
  final String q;

  FetchBook({@required this.q})
    : assert(q != null),
      super([q]);
}

class LoadMoreBook extends BookEvent {
  final String q;
  final int page;

  LoadMoreBook({@required this.q,this.page = 1})
    : assert(q != null),
      super([q,page]);
}

