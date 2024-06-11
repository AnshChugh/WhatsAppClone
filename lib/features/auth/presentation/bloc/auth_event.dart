part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final BuildContext context;
  final String phoneNumber;
  AuthLogin({required this.context, required this.phoneNumber});
}

final class AuthIsUserLoggedIn extends AuthEvent {}
