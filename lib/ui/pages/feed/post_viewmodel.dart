import 'package:meta/meta.dart';

class PostViewModel {
  final String title;
  final String description;
  final String content;
  final String author;
  final String publishedAt;
  final String relativePublishedAt;
  final bool highlight;
  final String url;
  final String imageUrl;

  PostViewModel({
    @required this.title,
    @required this.description,
    @required this.content,
    @required this.author,
    @required this.publishedAt,
    @required this.relativePublishedAt,
    @required this.highlight,
    @required this.url,
    @required this.imageUrl,
  });
}
