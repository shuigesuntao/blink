import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';


List<Book> getBookList(List<dynamic> list){
  List<Book> result = [];
  list.forEach((item){
    result.add(Book.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class Book extends Object {

  List<String> author;

  String binding;

  String category;

  int id;

  String image;

  Images images;

  String isbn;

  String pages;

  String price;

  String pubdate;

  String publisher;

  String subtitle;

  String summary;

  String title;

  List<dynamic> translator;

  Book(this.author,this.binding,this.category,this.id,this.image,this.images,this.isbn,this.pages,this.price,this.pubdate,this.publisher,this.subtitle,this.summary,this.title,this.translator,);

  factory Book.fromJson(Map<String, dynamic> srcJson) => _$BookFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookToJson(this);

}


@JsonSerializable()
class Images extends Object {

  String large;

  Images(this.large,);

  factory Images.fromJson(Map<String, dynamic> srcJson) => _$ImagesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);

}
