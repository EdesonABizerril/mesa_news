import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../main/helpers/theme_colors.dart';
import '../../../helpers/ui_errors.dart';
import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Modular.get<LoginPresenter>();
    return StreamBuilder<UIError>(
        stream: presenter.outPasswordError,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Senha",
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
                      obscureText: true,
                      onChanged: presenter.validatePassword,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
