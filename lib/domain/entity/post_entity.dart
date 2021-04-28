import 'package:meta/meta.dart';

class PostEntity {
  final String title;
  final String description;
  final String content;
  final String author;
  final DateTime publishedAt;
  final bool highlight;
  final String url;
  final String imageUrl;

  PostEntity({
    @required this.title,
    @required this.description,
    @required this.content,
    @required this.author,
    @required this.publishedAt,
    @required this.highlight,
    @required this.url,
    @required this.imageUrl,
  });
}
