import 'package:social_app/features/auth/domain/entities/app_user.dart';

abstract class AuthState {}

// initial state
class AuthInitial extends AuthState {}
//loading state

class AuthLoading extends AuthState {}

// loaded state

class Authenticated extends AuthState {
  final AppUser user;
  Authenticated({required this.user});
}

// unauthenticated state

class Unauthenticated extends AuthState {}
// Load failed satte

class AuthFailed extends AuthState {
  final dynamic error;

  AuthFailed({required this.error});
}
