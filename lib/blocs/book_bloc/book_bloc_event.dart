import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BookEvent extends Equatable {
  BookEvent([List props = const []]) : super(props);
}

class FetchBook extends BookEvent {
  final String q;
  final bool isRefresh;

  FetchBook({@required this.q,this.isRefresh = true})
    : assert(q != null),
      super([q,isRefresh]);
}


class LoadMoreBook extends BookEvent {
  final String q;
  final int page;

  LoadMoreBook({@required this.q,this.page = 1})
    : assert(q != null),
      super([q,page]);
}

