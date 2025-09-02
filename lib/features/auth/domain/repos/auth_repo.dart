abstract class AuthRepo {
  Future<AuthRepo?> loginwithemailpassword(String email, String password);

  Future<AuthRepo?> registerwithemailpassword(
    String email,
    String password,
    String name,
  );

  Future<AuthRepo> logout();

  Future<AuthRepo> getCurrentuser();
}
