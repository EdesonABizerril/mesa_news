import 'package:flutter/material.dart';
import 'package:mesa_news/ui/pages/feed/post_viewmodel.dart';

class PostItem extends StatelessWidget {
  final PostViewModel postViewModel;

  const PostItem({@required this.postViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.yellow,
      child: Center(child: Text(postViewModel.title)),
    );
  }
}
