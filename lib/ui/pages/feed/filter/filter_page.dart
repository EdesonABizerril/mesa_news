import 'package:flutter/material.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';
import 'package:mesa_news/ui/pages/feed/filter/components/filter_app_bar.dart';

import 'components/drop_down_filter.dart';
import 'components/switch_favorite.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.of(context).backgroundColor,
      appBar: PreferredSize(child: FilterAppBar(), preferredSize: Size.fromHeight(60)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
          child: Column(
            children: [
              Container(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Data',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    DropDownFilter(),
                  ],
                ),
              ),
              Divider(height: 2),
              Container(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Apenas favoritos',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SwitchFavorite(),
                  ],
                ),
              ),
              Divider(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}
