enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse,
  sessionExpired,
}

extension UIErrorExtension on UIError {
  String get description {
    switch(this) {
      case UIError.requiredField: return 'Campo obrigatório';
      case UIError.invalidField: return 'Campo inválido';
      case UIError.invalidCredentials: return 'Credenciais inválidas.';
      case UIError.emailInUse: return 'O email já está em uso.';
      case UIError.sessionExpired: return 'A sessão expirou. Verifique sua conexão';
      default: return 'Algo errado aconteceu. Verifique sua conexão.';
    }
  }
}