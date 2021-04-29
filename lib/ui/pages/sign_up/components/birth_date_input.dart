import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../main/helpers/theme_colors.dart';
import '../../../helpers/ui_errors.dart';
import '../sign_up_presenter.dart';

class BirthDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Modular.get<SignUpPresenter>();

    return StreamBuilder<UIError>(
      stream: presenter.outBirthDateError,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data de nascimento - opcional",
                style: TextStyle(
                  color: ThemeColors.of(context).fontSecondary,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 48,
                    margin: snapshot.hasData ? EdgeInsets.only(bottom: 10) : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: ThemeColors.of(context).backgroundField,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.start,
                    textAlignVertical: snapshot.hasData ? TextAlignVertical.bottom : TextAlignVertical.top,
                    decoration: InputDecoration(
                      errorText: snapshot.hasData ? snapshot.data.description : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                    onChanged: presenter.validateBirthDate,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
