import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/auth/domain/entities/app_user.dart';
import 'package:social_app/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginwithemailpassword(String email, String password) async {
    try {
      UserCredential userCredencial = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      AppUser user = AppUser(
        uid: userCredencial.user!.uid,
        email: email,
        name: "",
      );

      return user;
    } on FirebaseAuthException catch (ex) {
      throw FirebaseAuthException(code: ex.code, message: ex.message);
    }
  }

  @override
  Future<AppUser?> registerwithemailpassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredencial = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final FirebaseFirestore __firestore = FirebaseFirestore.instance;

      AppUser user = AppUser(
        uid: userCredencial.user!.uid,
        email: email,
        name: "",
      );
      await __firestore.collection("users").doc(user.uid).set({
        "name": name,
        "email": email,
        "uid": user.uid,
      });

      return user;
    } on FirebaseAuthException catch (ex) {
      throw FirebaseAuthException(code: ex.code, message: ex.message);
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentuser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    } else {
      return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? '',
      );
    }
  }
}
