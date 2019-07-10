// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
      (json['author'] as List)?.map((e) => e as String)?.toList(),
      json['binding'] as String,
      json['category'] as String,
      json['id'] as int,
      json['image'] as String,
      json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
      json['isbn'] as String,
      json['pages'] as String,
      json['price'] as String,
      json['pubdate'] as String,
      json['publisher'] as String,
      json['subtitle'] as String,
      json['summary'] as String,
      json['title'] as String,
      json['translator'] as List);
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'author': instance.author,
      'binding': instance.binding,
      'category': instance.category,
      'id': instance.id,
      'image': instance.image,
      'images': instance.images,
      'isbn': instance.isbn,
      'pages': instance.pages,
      'price': instance.price,
      'pubdate': instance.pubdate,
      'publisher': instance.publisher,
      'subtitle': instance.subtitle,
      'summary': instance.summary,
      'title': instance.title,
      'translator': instance.translator
    };

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return Images(json['large'] as String);
}

Map<String, dynamic> _$ImagesToJson(Images instance) =>
    <String, dynamic>{'large': instance.large};
