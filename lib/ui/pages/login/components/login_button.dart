import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';
import 'package:mesa_news/ui/pages/login/presenter/login_presenter.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Modular.get<LoginPresenter>();

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: StreamBuilder<bool>(
          stream: presenter.outIsFormValid,
          initialData: false,
          builder: (context, snapshot) {
            print("snapshot button ${snapshot.data}");
            return InkWell(
              radius: 5,
              child: Container(
                height: 48,
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: snapshot.data == true ? ThemeColors.of(context).primary: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 0,
                      color: Colors.transparent,
                    )),
              ),
              onTap: snapshot.data == true ? presenter.auth : null,
            );
          }),
    );
  }
}
