// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      title: json['title'] as String,
      description: json['description'] as String?,
      date: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      imageUrl: json['urlToImage'] as String?,
      source: _sourceNameFromJson(json['source']),
      text: json['content'] as String? ?? '',
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'publishedAt': instance.date?.toIso8601String(),
      'urlToImage': instance.imageUrl,
      'source': instance.source,
      'content': instance.text,
    };
