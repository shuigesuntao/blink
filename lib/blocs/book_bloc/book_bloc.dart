import 'package:blink/data/repository/book_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'book_bloc_event.dart';
import 'book_bloc_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc({@required this.bookRepository}) : assert(bookRepository != null);

  @override
  BookState get initialState => BookLoading();

  @override
  Stream<BookState> transform(Stream<BookEvent> events,
      Stream<BookState> Function(BookEvent event) next) {
    return super.transform(
      (events as Observable<BookEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    try {
      if (event is FetchBook) {
        if(!event.isRefresh){
          yield BookLoading();
        }
        final books = await bookRepository.getBooks(event.q, 1);
        yield books.isEmpty?BookEmpty():BookLoaded(books: books,currentPage: 1,isRefresh: event.isRefresh);
      }
      if (event is LoadMoreBook) {
        final books = await bookRepository.getBooks(event.q, event.page);
        yield BookLoaded(
            books: currentState is BookLoaded ? (currentState as BookLoaded).books + books : books,
            isLoadMore: true,currentPage: event.page);
      }
    } catch (e) {
      yield BookError(msg: e.msg ?? e.message);
    }
  }

}
