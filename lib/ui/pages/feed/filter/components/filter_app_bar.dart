import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../main/helpers/theme_colors.dart';
import '../../feed_presenter.dart';

class FilterAppBar extends StatelessWidget {
  final feedPresenter = Modular.get<FeedPresenter>();

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
          onPressed: feedPresenter.resetFilterPosts,
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
