import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/domain/entities/app_user.dart';
import 'package:social_app/features/auth/domain/repos/auth_repo.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo; // Remove nullable if it's always provided
  AppUser? _currentUser; // Remove final and make nullable
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // check if user is already Authenticated
  void checkUser() async {
    emit(AuthLoading()); // Add loading state
    try {
      final AppUser? user = await authRepo.getCurrentuser();

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      print("CheckUser Error: $e");
      emit(AuthFailed(error: e)); //Fixed error parameter
    }
  }

  /* 
  
  get current user
  
  . */
  AppUser? getCurrentUser() => _currentUser;

  //login with email and pw

  Future<void> login(String email, String pw) async {
    try {
      emit(AuthLoading());

      final user = await authRepo.loginwithemailpassword(email, pw);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailed(error: e));
    }
  }

  Future<void> register(String name, String email, String pw) async {
    
    try {
      emit(AuthLoading());

      final user = await authRepo.registerwithemailpassword(name, email, pw);

      if (user != null) {
        _currentUser = user;
         await _firestore.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      print("Register Error: $e");
      emit(AuthFailed(error: e));
    }
  }

  Future<void> logout() async {
    print('Logout called manually');
    try {
      await authRepo.logout();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailed(error: e));
    }
  }
}
