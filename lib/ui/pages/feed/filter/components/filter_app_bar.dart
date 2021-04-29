import 'package:flutter/material.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';

class FilterAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Filtro'),
      brightness: Brightness.dark,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: ThemeColors.of(context).fontFeatured,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Limpar',
            style: TextStyle(
              color: ThemeColors.of(context).fontFeatured,
              fontSize: 17,
            ),
          ),
        )
      ],
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: ThemeColors.of(context).primary,
    );
    ;
  }
}
