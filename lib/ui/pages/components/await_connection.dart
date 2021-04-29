import 'package:flutter/material.dart';

import '../../../main/helpers/theme_colors.dart';
import '../../helpers/lang/app-localizations.dart';

class AwaitConnectionWidget extends StatelessWidget {
  final Duration duration;
  final Function onTap;

  const AwaitConnectionWidget({Key key, this.duration = const Duration(seconds: 15), this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: Future.delayed(duration, () => true),
        initialData: false,
        builder: (context, snapshot) {
          return snapshot.data
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        width: 300,
                        child: Text(
                          AppLocalizations.of(context).translate("nao_ha_conexao_com_a_internet"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 300,
                        child: Text(
                          AppLocalizations.of(context).translate("verifique_conexao"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        margin: EdgeInsets.only(top: 20),
                        color: Colors.grey,
                        child: TextButton(
                          onPressed: onTap,
                          child: Text(
                            AppLocalizations.of(context).translate('atualizar'),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ))
              : FutureBuilder<bool>(
                  future: Future.delayed(Duration(milliseconds: 100), () => true),
                  initialData: false,
                  builder: (context, snapshot) {
                    return snapshot.data
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.of(context).primary),
                              ),
                            ),
                          )
                        : Container();
                  });
        });
  }
}
