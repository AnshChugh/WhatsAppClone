import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const CustomButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          backgroundColor: tabColor,
          minimumSize: const Size(double.infinity, 50)),
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
