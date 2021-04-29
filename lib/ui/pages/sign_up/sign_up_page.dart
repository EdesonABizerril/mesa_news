import 'package:flutter/material.dart';

import '../../../main/helpers/theme_colors.dart';
import '../components/custom_main_app_bar.dart';
import 'components/birth_date_input.dart';
import 'components/email_input.dart';
import 'components/name_input.dart';
import 'components/password_confirmation_input.dart';
import 'components/password_input.dart';
import 'components/signup_button.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.of(context).backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomMainAppBar(
            title: Text("Cadastrar"),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Form(
            child: Column(
              children: <Widget>[
                NameInput(),
                Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: EmailInput(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: PasswordInput(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: PasswordConfirmationInput(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: BirthDateInput(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: SignUpButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
