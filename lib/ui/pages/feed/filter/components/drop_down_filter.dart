import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mesa_news/ui/helpers/filter_period.dart';

import '../../feed_presenter.dart';

class DropDownFilter extends StatefulWidget {
  @override
  _DropDownFilterState createState() => _DropDownFilterState();
}

class _DropDownFilterState extends State<DropDownFilter> {
  final feedPresenter = Modular.get<FeedPresenter>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FilterPeriod>(
        stream: feedPresenter.outPeriodFilter,
        initialData: feedPresenter.getPeriodFilter,
        builder: (context, snapshot) {
          return DropdownButton<String>(
            value: snapshot.data.description,
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            iconSize: 18,
            elevation: 16,
            style: const TextStyle(
              color: Colors.black,
            ),
            isDense: true,
            underline: Container(
              height: 0,
              color: Colors.white,
            ),
            onChanged: (String value) {
              FilterPeriod selected;

              if (value == FilterPeriod.all.description)
                selected = FilterPeriod.all;
              else if (value == FilterPeriod.thisWeek.description)
                selected = FilterPeriod.thisWeek;
              else if (value == FilterPeriod.lastWeek.description)
                selected = FilterPeriod.lastWeek;
              else if (value == FilterPeriod.thisMonth.description) selected = FilterPeriod.thisMonth;

              feedPresenter.inPeriodFilter.add(selected);
            },
            items: <String>[
              FilterPeriod.all.description,
              FilterPeriod.thisWeek.description,
              FilterPeriod.lastWeek.description,
              FilterPeriod.thisMonth.description,
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }).toList(),
          );
        });
    ;
  }
}
