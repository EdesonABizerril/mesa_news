import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';
import 'package:mesa_news/ui/pages/login/presenter/login_presenter.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginPresenter = Modular.get<LoginPresenter>();

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: StreamBuilder<bool>(
          stream: loginPresenter.outIsFormValid,
          initialData: false,
          builder: (context, snapshot) {
            return InkWell(
              radius: 5,
              child: StreamBuilder<bool>(
                  stream: loginPresenter.outIsLoading,
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
                              "Login",
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
              onTap: snapshot.data == true ? (!loginPresenter.getIsLoading ? loginPresenter.auth : null) : null,
            );
          }),
    );
  }
}
