import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/cache/cache_storage.dart';
import '../../domain/helpers/domain_error.dart';
import '../../domain/usercases/add_account.dart';
import '../../domain/usercases/current_account.dart';
import '../../ui/helpers/ui_errors.dart';
import '../../ui/pages/sign_up/sign_up_presenter.dart';
import '../protocols/validation.dart';
import 'mixins/mixin_modular_loading_stream.dart';
import 'mixins/mixin_modular_stream_validates.dart';

class ModularSignUpPresenter extends Disposable
    with ModularStreamValidates, ModularLoadingStream
    implements SignUpPresenter {
  final Validation validation;
  final AddAccount addAccount;
  final CurrentAccount currentAccount;
  final CacheStorage cacheStorage;

  ModularSignUpPresenter({
    @required this.validation,
    @required this.addAccount,
    @required this.currentAccount,
    @required this.cacheStorage,
  });

  final _nameErrorController = BehaviorSubject<UIError>();
  Sink<UIError> get inNameError => _nameErrorController.sink;
  Stream<UIError> get outNameError => _nameErrorController.stream;
  UIError get getNameError => _nameErrorController.valueWrapper?.value;

  final _passwordConfirmationErrorController = BehaviorSubject<UIError>();
  Sink<UIError> get inPasswordConfirmationError => _passwordConfirmationErrorController.sink;
  Stream<UIError> get outPasswordConfirmationError => _passwordConfirmationErrorController.stream;
  UIError get getPasswordConfirmationError => _passwordConfirmationErrorController.valueWrapper?.value;

  final _birthDateErrorController = BehaviorSubject<UIError>();
  Sink<UIError> get inBirthDateError => _birthDateErrorController.sink;
  Stream<UIError> get outBirthDateError => _birthDateErrorController.stream;
  UIError get getBirthDateError => _birthDateErrorController.valueWrapper?.value;

  String _email;
  String _name;
  String _password;
  String _passwordConfirmation;
  String _birthDate = "";

  void validateEmail(String email) {
    _email = email;
    inEmailError.add(_validateField('email'));
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    inNameError.add(_validateField('name'));
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    inPasswordError.add(_validateField('password'));
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    if (passwordConfirmation != _password) {
      inPasswordConfirmationError.add(UIError.invalidCredentials);
      return;
    }
    inPasswordConfirmationError.add(_validateField('passwordConfirmation'));
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation
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
    inIsFormValid.add(getEmailError == null &&
        getNameError == null &&
        getPasswordError == null &&
        getPasswordConfirmationError == null &&
        _name != null &&
        _email != null &&
        _password != null &&
        _passwordConfirmation != null);
  }

  Future<void> signUp() async {
    try {
      inIsLoading.add(true);
      final account = await addAccount.add(AddAccountParams(
        name: _name,
        email: _email,
        password: _password,
      ));
      await currentAccount.save(account);
      if (_birthDate.isNotEmpty) await cacheStorage.put(key: "birthDate", value: _birthDate);
      Modular.to.pushReplacementNamed('/feed');
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.emailInUse:
          inEmailError.add(UIError.emailInUse);
          break;
        default:
          inEmailError.add(UIError.unexpected);
          break;
      }
    }
    inIsLoading.add(false);
  }

  @override
  void validateBirthDate(String birthData) {
    _birthDate = birthData;
  }

  @override
  void dispose() {
    _nameErrorController?.close();
    _passwordConfirmationErrorController?.close();
    _birthDateErrorController?.close();
    loadingDispose();
  }
}
