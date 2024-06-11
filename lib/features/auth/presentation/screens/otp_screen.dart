import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/colors.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Verifying Your Number'),
        
      ),
    );
  }
}
