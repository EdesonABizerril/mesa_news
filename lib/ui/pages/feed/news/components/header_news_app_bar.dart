import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../main/helpers/theme_colors.dart';
import '../../post_viewmodel.dart';

class HeaderNewsAppBar extends StatelessWidget {
  final PostViewModel postViewModel;

  const HeaderNewsAppBar({Key key, @required this.postViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      color: ThemeColors.of(context).primary,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(bottom: 10),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: Modular.to.pop,
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_horiz, color: Colors.white),
          onPressed: () {},
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              postViewModel.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              postViewModel.author,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
