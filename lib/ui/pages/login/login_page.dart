import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';
import 'package:mesa_news/ui/pages/login/components/login_access_buttons.dart';

import 'presenter/login_presenter.dart';

class LoginPage extends StatelessWidget {
  final loginPresenter = Modular.get<LoginPresenter>();

  @override
  Widget build(BuildContext context) {
    final _isOrientationPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: ThemeColors.of(context).primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: _isOrientationPortrait
                      ? MediaQuery.of(context).size.height * 0.20
                      : MediaQuery.of(context).size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'lib/ui/assets/logo1.svg',
                        height: _isOrientationPortrait ? 101 : 101 / 2,
                        width: _isOrientationPortrait ? 116 : 116 / 2,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 20),
                      SvgPicture.asset(
                        'lib/ui/assets/NEWS.svg',
                        width: _isOrientationPortrait ? 116 : 116 / 2,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                FutureBuilder<bool>(
                    future: loginPresenter.checkAccount(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Positioned(
                              bottom: 42,
                              left: 0,
                              right: 0,
                              child: LoginAccessButtons(),
                            )
                          : Positioned(
                              bottom: 130,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
