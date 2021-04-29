import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../post_viewmodel.dart';

class CardHighlightPost extends StatelessWidget {
  final PostViewModel postViewModel;

  const CardHighlightPost({Key key, @required this.postViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _widthSize = MediaQuery.of(context).size.width * 0.9;
    final _heightSize = 175.0;
    double _widthImage = 120.0;
    return Container(
      height: 175,
      padding: EdgeInsets.only(right: 15),
      width: _widthSize,
      child: Card(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              postViewModel.imageUrl,
              height: 170,
              width: _widthImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 170,
                width: _widthImage,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 5),
              child: Column(
                children: [
                  Container(
                    width: _widthSize - _widthImage - 80,
                    height: _heightSize - 50.0,
                    child: AutoSizeText(
                      postViewModel.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('lib/ui/assets/Saved.svg', height: 30),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: AutoSizeText(
                            postViewModel.relativePublishedAt,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
