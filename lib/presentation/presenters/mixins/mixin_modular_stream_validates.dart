import 'package:flutter_modular/flutter_modular.dart';
import 'package:mesa_news/ui/helpers/ui_errors.dart';
import 'package:rxdart/rxdart.dart';

mixin ModularStreamValidates on Disposable {
  final _emailErrorController = BehaviorSubject<UIError>();
  Sink<UIError> get inEmailError => _emailErrorController.sink;
  Stream<UIError> get outEmailError => _emailErrorController.stream;
  UIError get getEmailError =>  _emailErrorController.valueWrapper?.value;

  final _passwordErrorController = BehaviorSubject<UIError>();
  Sink<UIError> get inPasswordError => _passwordErrorController.sink;
  Stream<UIError> get outPasswordError => _passwordErrorController.stream;
  UIError get getPasswordError => _passwordErrorController.valueWrapper?.value;

  final _isFormValidController = BehaviorSubject<bool>.seeded(false);
  Sink<bool> get inIsFormValid => _isFormValidController.sink;
  Stream<bool> get outIsFormValid => _isFormValidController.stream;

  @override
  void dispose() {
    _emailErrorController?.close();
    _passwordErrorController?.close();
    _isFormValidController?.close();
  }


}