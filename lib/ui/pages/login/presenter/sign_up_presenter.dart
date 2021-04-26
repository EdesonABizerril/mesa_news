import 'package:mesa_news/ui/helpers/ui_errors.dart';

abstract class SignUpPresenter {
  Sink<UIError> get inEmailError;
  Stream<UIError> get outEmailError;

  Sink<UIError> get inPasswordError;
  Stream<UIError> get outPasswordError;

  Sink<bool> get inIsLoading;
  Stream<bool> get outIsLoading;
  bool get getIsLoading;

  Sink<bool> get inIsFormValid;
  Stream<bool> get outIsFormValid;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);
  void validateBirthDate(String birthData);
  Future<void> signUp();

}