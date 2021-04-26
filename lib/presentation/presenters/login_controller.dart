import 'package:mesa_news/domain/usercases/current_account.dart';
import 'package:meta/meta.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

import '../../presentation/protocols/validation.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/usercases/authentication.dart';
import '../../ui/helpers/ui_errors.dart';
import '../../ui/pages/login/presenter/login_presenter.dart';

class LoginController extends Disposable implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final CurrentAccount currentAccount;

  LoginController({@required this.validation, @required this.authentication, @required this.currentAccount});

  final _emailErrorController = BehaviorSubject<UIError>();
  Sink<UIError> get inEmailError => _emailErrorController.sink;
  Stream<UIError> get outEmailError => _emailErrorController.stream;

  final _passwordErrorController = BehaviorSubject<UIError>();
  Sink<UIError> get inPasswordError => _passwordErrorController.sink;
  Stream<UIError> get outPasswordError => _passwordErrorController.stream;

  final _isLoadingController = BehaviorSubject<bool>.seeded(false);
  Sink<bool> get inIsLoading => _isLoadingController.sink;
  Stream<bool> get outIsLoading => _isLoadingController.stream;

  final _isFormValidController = BehaviorSubject<bool>.seeded(false);
  Sink<bool> get inIsFormValid => _isFormValidController.sink;
  Stream<bool> get outIsFormValid => _isFormValidController.stream;

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
      inIsLoading.add(true);
    }
  }

  Future<bool> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await currentAccount.load();
      if (account?.token != null) Modular.to.pushReplacementNamed('/feed');
      return false;
    } catch (error) {
      return false;
    }
  }

  @override
  void goToSignUp() {
    // TODO: implement goToSignUp
  }

  @override
  void validateEmail(String email) {
    _email = email;
    _emailErrorController.add(_validateField('email'));
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordErrorController.add(_validateField('password'));
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
      _emailErrorController.valueWrapper?.value == null &&
          _passwordErrorController.valueWrapper?.value == null &&
          _email != null &&
          _password != null,
    );
  }

  @override
  void dispose() {
    _emailErrorController?.close();
    _passwordErrorController?.close();
    _isLoadingController?.close();
    _isFormValidController?.close();
  }
}
