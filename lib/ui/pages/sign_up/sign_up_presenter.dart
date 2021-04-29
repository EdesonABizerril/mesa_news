import '../../helpers/ui_errors.dart';

abstract class SignUpPresenter {
  Sink<UIError> get inEmailError;
  Stream<UIError> get outEmailError;

  Sink<UIError> get inNameError;
  Stream<UIError> get outNameError;

  Sink<UIError> get inPasswordError;
  Stream<UIError> get outPasswordError;

  Sink<UIError> get inPasswordConfirmationError;
  Stream<UIError> get outPasswordConfirmationError;

  Sink<UIError> get inBirthDateError;
  Stream<UIError> get outBirthDateError;

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
