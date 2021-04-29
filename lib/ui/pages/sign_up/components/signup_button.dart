import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../main/helpers/theme_colors.dart';
import '../sign_up_presenter.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpPresenter = Modular.get<SignUpPresenter>();

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: StreamBuilder<bool>(
          stream: signUpPresenter.outIsFormValid,
          initialData: false,
          builder: (context, snapshot) {
            return InkWell(
              radius: 5,
              child: StreamBuilder<bool>(
                  stream: signUpPresenter.outIsLoading,
                  initialData: false,
                  builder: (context, isLoading) {
                    return Container(
                      height: 48,
                      child: isLoading.data
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              "Cadastrar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: snapshot.data == true ? ThemeColors.of(context).primary : Colors.grey[400],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 0,
                            color: Colors.transparent,
                          )),
                    );
                  }),
              onTap: snapshot.data == true ? (!signUpPresenter.getIsLoading ? signUpPresenter.signUp : null) : null,
            );
          }),
    );
  }
}
