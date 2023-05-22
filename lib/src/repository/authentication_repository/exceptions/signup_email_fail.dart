class SignUpWithEmailAndPasswordFailure {
  final String? message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "An Unknown error occurred."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'week-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Please enter a stronger password.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'Email invalid.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'Email already in use.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation not allowed.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'User disabled.');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
