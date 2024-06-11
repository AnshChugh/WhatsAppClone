
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/landing/landing_screen.dart';
import 'package:whatsapp_clone/init_dependencies.dart';
import 'package:whatsapp_clone/theme/colors.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp Clone',
        theme: ThemeData.dark(useMaterial3: true)
            .copyWith(scaffoldBackgroundColor: backgroundColor),
        home: const LandingScreen());
  }
}
