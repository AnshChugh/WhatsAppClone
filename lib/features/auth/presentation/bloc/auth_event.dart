part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final BuildContext context;
  final String phoneNumber;
  AuthLogin({required this.context, required this.phoneNumber});
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthVerifyOtp extends AuthEvent {
  final BuildContext context;
  final String verificationId;
  final String otp;
  AuthVerifyOtp({required this.context, required this.verificationId, required this.otp});
}
