import 'package:social_app/features/auth/domain/repos/auth_repo.dart';



class FirebaseAuthRepo implements AuthRepo {

@override
  Future<AuthRepo?> loginwithemailpassword(String email, String password) {
    // TODO: implement loginwithemailpassword
    throw UnimplementedError();
  }


  @override
  Future<AuthRepo?> registerwithemailpassword(String email, String password, String name) {
    // TODO: implement registerwithemailpassword
    throw UnimplementedError();
  }


  @override
  Future<AuthRepo> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }


  @override
  Future<AuthRepo> getCurrentuser() {
    // TODO: implement getCurrentuser
    throw UnimplementedError();
  }


}