import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';
import 'package:mesa_news/ui/pages/components/custom_main_app_bar.dart';
import 'package:mesa_news/ui/pages/login/components/login_button.dart';
import 'package:mesa_news/ui/pages/login/components/login_access_buttons.dart';

import 'components/email_input.dart';
import 'components/password_input.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.of(context).backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomMainAppBar(
            title: Text("Entrar com e-mail"),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                'lib/ui/assets/noun_login.svg',
                height: 117,
                width: 118,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      EmailInput(),
                      Padding(
                        padding: EdgeInsets.only(top: 35, bottom: 30),
                        child: PasswordInput(),
                      ),
                      LoginButton(),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: LoginAccessButtons(enableEmailPasswordButton: false),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
