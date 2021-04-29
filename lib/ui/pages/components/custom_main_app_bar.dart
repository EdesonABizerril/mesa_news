import 'package:flutter/material.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';
import 'package:meta/meta.dart';

class CustomMainAppBar extends StatelessWidget {
  final Text title;

  const CustomMainAppBar({
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      brightness: Brightness.dark,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.close),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: ThemeColors.of(context).primary,
    );
  }
}
