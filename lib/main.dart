import 'package:blink/pages/book_list_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'data/repository/book_repository.dart';

class AppBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  final BookRepository bookRepository = BookRepository();
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          builder: (context) => ThemeBloc(),
        ),
      ],
      child: MyApp(bookRepository: bookRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final BookRepository bookRepository;

  MyApp({Key key, @required this.bookRepository})
      : assert(bookRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ThemeBloc>(context),
      builder: (_, ThemeState themeState) {
        return MaterialApp(
            title: 'Flutter Book',
            theme: themeState.type == ThemeType.light ? ThemeData.light() : ThemeData.dark(),
            home: BlocProvider(
              builder: (context) => BookBloc(bookRepository: BookRepository())..dispatch(FetchBook(q: "郭敬明",isRefresh: false)),
              child: BookListPage(),
            )
        );
      },
    );
  }
}