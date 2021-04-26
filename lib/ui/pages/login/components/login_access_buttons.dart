import 'package:flutter/material.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';

class LoginAccessButtons extends StatelessWidget {
  final bool enableFacebookButton;
  final bool enableEmailPasswordButton;
  final bool enableSignUpButton;

  const LoginAccessButtons(
      {Key key,
      this.enableFacebookButton = true,
      this.enableEmailPasswordButton = true,
      this.enableSignUpButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        enableFacebookButton
            ? Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: InkWell(
                  radius: 5,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: enableEmailPasswordButton ? 0 : 1,
                          color: enableEmailPasswordButton ? Colors.transparent : ThemeColors.of(context).borderColor,
                        )),
                    child: Text(
                      'Entrar com o facebook',
                      style: TextStyle(
                        color: enableEmailPasswordButton
                            ? ThemeColors.of(context).fontFeatured
                            : ThemeColors.of(context).fontSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    // TODO: fazer chamada ao login facebook
                  },
                ),
              )
            : Container(),
        enableEmailPasswordButton
            ? Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: InkWell(
                  radius: 5,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemeColors.of(context).primary,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Text(
                      'Entrar com e-mail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/signIn");
                  },
                ),
              )
            : Container(),
        enableSignUpButton
            ? Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 35),
                child: GestureDetector(
                  child: Container(
                    height: 30,
                    color: Colors.transparent, // able to touch
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não tenho conta.',
                          style: TextStyle(
                            color: enableEmailPasswordButton
                                ? Colors.white
                                : ThemeColors.of(context).fontPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: ThemeColors.of(context).fontFeatured,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/signUp");
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
