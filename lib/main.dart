import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/common/cubit/app_user_cubit_cubit.dart';
import 'package:whatsapp_clone/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:whatsapp_clone/features/landing/landing_screen.dart';
import 'package:whatsapp_clone/init_dependencies.dart';
import 'package:whatsapp_clone/theme/colors.dart';

void main() async {
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => serviceLocator<AppUserCubitCubit>(),
    ),
    BlocProvider(
      create: (context) => serviceLocator<AuthBloc>(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp Clone',
        theme: ThemeData.dark(useMaterial3: true)
            .copyWith(scaffoldBackgroundColor: backgroundColor),
        home: BlocSelector<AppUserCubitCubit, AppUserCubitState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return const Scaffold(body: Text('log in'));
            }
            return const LandingScreen();
          },
        ));
  }
}
