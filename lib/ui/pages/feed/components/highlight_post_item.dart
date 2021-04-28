import 'package:flutter/material.dart';
import '../post_viewmodel.dart';

class HighlightPostItem extends StatelessWidget {
  final PostViewModel postViewModel;

  const HighlightPostItem({Key key, @required this.postViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 150,
      child: Center(
        child: Text(postViewModel.title),
      ),
    );
  }
}
