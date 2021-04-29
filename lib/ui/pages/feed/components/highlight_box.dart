import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../post_viewmodel.dart';
import 'highlight_post_item.dart';

class HeaderBox extends StatelessWidget {
  final List<PostViewModel> listPostViewModel;

  const HeaderBox({Key key, @required this.listPostViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, bottom: 15),
          child: Text(
            'Destaques',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            enableInfiniteScroll: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 10),
            viewportFraction: 0.9,
          ),
          items: listPostViewModel.map((viewModel) => CardHighlightPost(postViewModel: viewModel)).toList(),
        ),
        Container(
          margin: EdgeInsets.only(left: 16, top: 30, bottom: 15),
          child: Text(
            'Últimas notícias',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
