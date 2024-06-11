import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whatsapp_clone/core/common/cubit/app_user_cubit_cubit.dart';
import 'package:whatsapp_clone/core/network/connection_checker.dart';
import 'package:whatsapp_clone/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:whatsapp_clone/features/auth/data/repository/auth_repository_impl.dart';
import 'package:whatsapp_clone/features/auth/domain/repository/auth_repository.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/current_user.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/user_login.dart';
import 'package:whatsapp_clone/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:whatsapp_clone/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  serviceLocator
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerFactory(() => InternetConnection())
    ..registerFactory<ConnectionChecker>(
        () => ConnectionCheckerImpl(serviceLocator()));

  //core
  serviceLocator.registerLazySingleton(
    () => AppUserCubitCubit(),
  );

  _initAuth();
}

void _initAuth() {
  serviceLocator
    // datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSource(serviceLocator(), serviceLocator()),
    )
    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    // use case
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))

    // bloc
    ..registerLazySingleton(() => AuthBloc(
          userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}
