import 'package:social_app/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  // logion
  Future<AppUser?> loginwithemailpassword(String email, String password);

  // signin
  Future<AppUser?> registerwithemailpassword(
    String name,
    String email,
    String password,
  );

  //signout
  Future<void> logout();

  // user info
  Future<AppUser?> getCurrentuser();
}
