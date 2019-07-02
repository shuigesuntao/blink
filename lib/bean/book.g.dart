// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num)?.toDouble());
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'price': instance.price,
      'name': instance.name,
      'id': instance.id
    };
