import '../../helpers/ui_errors.dart';

abstract class LoginPresenter {
  Sink<UIError> get inEmailError;
  Stream<UIError> get outEmailError;

  Sink<UIError> get inPasswordError;
  Stream<UIError> get outPasswordError;

  Sink<bool> get inIsLoading;
  Stream<bool> get outIsLoading;
  bool get getIsLoading;

  Sink<bool> get inIsFormValid;
  Stream<bool> get outIsFormValid;

  Future<void> auth();
  Future<void> checkAccount({int durationInSeconds = 2});

  void validateEmail(String email);
  void validatePassword(String password);
}
