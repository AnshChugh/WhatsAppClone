import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/auth/presentation/screens/otp_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OtpScreen(verificationId: verificationId));
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Text('This page doesn\'t exist'),
        ),
      );
  }
}
