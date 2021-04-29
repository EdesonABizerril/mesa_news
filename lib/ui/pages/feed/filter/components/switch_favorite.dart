import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../main/helpers/theme_colors.dart';
import '../../feed_presenter.dart';

class SwitchFavorite extends StatefulWidget {
  @override
  _SwitchFavoriteState createState() => _SwitchFavoriteState();
}

class _SwitchFavoriteState extends State<SwitchFavorite> {
  final feedPresenter = Modular.get<FeedPresenter>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: feedPresenter.outFavoriteFilter,
        initialData: feedPresenter.getFavoriteFilter,
        builder: (context, snapshot) {
          return Switch(
            activeColor: HexColor('#4CD964'),
            onChanged: (bool value) {
              feedPresenter.inFavoriteFilter.add(value);
            },
            value: snapshot.data,
          );
        });
  }
}
