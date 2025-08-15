import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/news/domain/entities/news.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel extends News {
  @override
  @JsonKey(name: 'title')
  final String title;

  @override
  @JsonKey(name: 'description')
  final String? description;

  @override
  @JsonKey(name: 'publishedAt')
  final DateTime? date;

  @override
  @JsonKey(name: 'urlToImage')
  final String? imageUrl;

  @override
  @JsonKey(name: 'source', fromJson: _sourceNameFromJson)
  final String source;

  @JsonKey(name: 'content', defaultValue: '')
  final String text;

  NewsModel({
    required this.title,
    this.description,
    this.date,
    this.imageUrl,
    required this.source,
    required this.text,
  }) : super(
          title: title,
          description: description,
          date: date,
          imageUrl: imageUrl,
          source: source,
          text: text,
        );

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  factory NewsModel.fromEntity(News news) {
    return NewsModel(
      source: news.source,
      title: news.title,
      description: news.description,
      imageUrl: news.imageUrl,
      date: news.date,
      text: news.text,
    );
  }

}

String _sourceNameFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return json['name'] ?? 'Unknown';
  } else if (json is String) {
    return json;
  } else {
    return 'Unknown';
  }
}
