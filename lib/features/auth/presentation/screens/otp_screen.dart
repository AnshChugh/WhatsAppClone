import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/verify_top.dart';
import 'package:whatsapp_clone/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:whatsapp_clone/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Verifying Your Number'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                onChanged: (val) {
                  if (val.length == 6) {
                    context.read<AuthBloc>().add(AuthVerifyOtp(
                        context: context,
                        verificationId: widget.verificationId,
                        otp: val));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
