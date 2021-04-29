import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesa_news/ui/pages/feed/post_viewmodel.dart';

class PostItem extends StatelessWidget {
  final PostViewModel postViewModel;

  const PostItem({@required this.postViewModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/news', arguments: postViewModel);
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Image.network(
              postViewModel.imageUrl,
              height: 170,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 170,
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
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: SvgPicture.asset(
                        'lib/ui/assets/Saved.svg',
                        height: 30,
                      )),
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
            Container(
              margin: EdgeInsets.only(top: 11),
              alignment: Alignment.centerLeft,
              child: Text(
                postViewModel.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                postViewModel.description,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Divider(height: 32),
          ],
        ),
      ),
    );
  }
}
