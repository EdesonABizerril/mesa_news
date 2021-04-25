abstract class LoginPresenter {
  Future<void> auth();
  void goToSignUp();

  void validateEmail(String email);
  void validatePassword(String password);
}
