import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'main/app_module.dart';
import 'main/app_widget.dart';

void main() {
  runApp(ModularApp(
    module: AppModule(),
    child: AppWidget(),
  ));
}
