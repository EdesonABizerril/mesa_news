import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';

import '../../domain/helpers/domain_error.dart';
import '../../domain/usercases/authentication.dart';
import '../../domain/usercases/current_account.dart';
import '../../presentation/protocols/validation.dart';
import '../../ui/helpers/ui_errors.dart';
import '../../ui/pages/login/login_presenter.dart';
import 'mixins/mixin_modular_loading_stream.dart';
import 'mixins/mixin_modular_stream_validates.dart';

class ModularLoginController extends Disposable
    with ModularStreamValidates, ModularLoadingStream
    implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final CurrentAccount currentAccount;

  ModularLoginController({@required this.validation, @required this.authentication, @required this.currentAccount});

  String _email;
  String _password;

  @override
  Future<void> auth() async {
    try {
      inIsLoading.add(true);
      final account = await authentication.auth(AuthenticationParams(email: _email, secret: _password));
      await currentAccount.save(account);
      Modular.to.pushReplacementNamed('feed');
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          inEmailError.add(UIError.invalidCredentials);
          break;
        default:
          inEmailError.add(UIError.requiredField);
          break;
      }
    }
    inIsLoading.add(false);
  }

  bool _isGoTo = true;
  Future<bool> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await currentAccount.load();
      if (account?.token != null && _isGoTo) Modular.to.pushReplacementNamed('/feed');
      _isGoTo = false;
      return null;
    } catch (error) {
      _isGoTo = true;
      return false;
    }
  }

  @override
  void validateEmail(String email) {
    _email = email;
    inEmailError.add(_validateField('email'));
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    inPasswordError.add(_validateField('password'));
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
    };
    final error = validation.validate(field: field, input: formData);

    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    inIsFormValid.add(
      getEmailError == null && getPasswordError == null && _email != null && _password != null,
    );
  }

  @override
  void dispose() {
    loadingDispose();
  }
}
