import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/presentation/screens/login_screen.dart';
import 'package:whatsapp_clone/theme/colors.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void goToLoginScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(fontSize: 33, color: textColor),
            ),
            SizedBox(
              height: height / 9,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                'assets/bg.png',
                color: tabColor,
              ),
            ),
            SizedBox(
              height: height / 9,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Read Our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 0.75 * width,
              child: CustomButton(
                buttonText: 'AGREE AND CONTINUE',
                onTap: () => goToLoginScreen(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
