import 'package:mesa_news/data/http/http_error.dart';
import 'package:mesa_news/domain/entity/post_entity.dart';
import 'package:meta/meta.dart';

class RemotePostModel {
  final String title;
  final String description;
  final String content;
  final String author;
  final String publishedAt;
  final bool highlight;
  final String url;
  final String imageUrl;

  RemotePostModel({
    @required this.title,
    @required this.description,
    @required this.content,
    @required this.author,
    @required this.publishedAt,
    @required this.highlight,
    @required this.url,
    @required this.imageUrl,
  });

  factory RemotePostModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'title',
      'description',
      'content',
      'author',
      'published_at',
      'highlight',
      'url',
      'image_url'
    ])) {
      throw HttpError.invalidData;
    }
    return RemotePostModel(
      title: json['title'],
      description: json['description'],
      content: json['content'],
      author: json['author'],
      publishedAt: json['published_at'],
      highlight: json['highlight'],
      url: json['url'],
      imageUrl: json['image_url'],
    );
  }

  PostEntity toEntity() => PostEntity(
        title: title,
        description: description,
        content: content,
        author: author,
        publishedAt: DateTime.parse(publishedAt),
        highlight: highlight,
        url: url,
        imageUrl: imageUrl,
      );
}
