import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../post_viewmodel.dart';
import 'highlight_post_item.dart';

class HighlightBox extends StatelessWidget {
  final List<PostViewModel> listPostViewModel;

  const HighlightBox({Key key, @required this.listPostViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 1),
      items: listPostViewModel.map((viewModel) => HighlightPostItem(postViewModel: viewModel)).toList(),
    );
  }
}
