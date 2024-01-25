class Account {
  final String email;
  final String password;

  Account({
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'Account(email: $email, password: $password)';
  }
}