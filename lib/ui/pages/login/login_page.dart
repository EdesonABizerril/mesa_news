import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final loginPresenter = Modular.get<LoginPresenter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Center(child: Column(
          children: [
            Text("body"),
            RaisedButton(
              child: Text("Login"),
                onPressed: (){
              // loginPresenter.validateEmail('john@doe.com');
              // loginPresenter.validatePassword('123456');
              loginPresenter.auth();
            }),
          ],
        )),
      ),
    );
  }
}
