import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../main/helpers/theme_colors.dart';
import '../post_viewmodel.dart';
import 'components/header_news_app_bar.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = Modular.args.data;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: Container(
            color: ThemeColors.of(context).primary,
          ),
          preferredSize: Size.zero),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              HeaderNewsAppBar(postViewModel: postViewModel),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Image.network(
                        postViewModel.imageUrl,
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 230,
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
                              postViewModel.publishedAt,
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
                      child: AutoSizeText(
                        postViewModel.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 11),
                      child: Text(
                        postViewModel.content,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
