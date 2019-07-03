import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

List<Book> getBookList(List<dynamic> list) {
  List<Book> result = [];
  list.forEach((item) {
    result.add(Book.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Book {
  double price;
  String name;
  int id;

  Book({this.id, this.name, this.price});

  factory Book.fromJson(Map<String, dynamic> srcJson) =>
      _$BookFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
