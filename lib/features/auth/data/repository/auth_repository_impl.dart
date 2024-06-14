import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/common/entities/user.dart';
import 'package:whatsapp_clone/core/error/failure.dart';
import 'package:whatsapp_clone/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:whatsapp_clone/features/auth/domain/repository/auth_repository.dart';
import 'package:whatsapp_clone/core/network/connection_checker.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.authRemoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    final user = await authRemoteDataSource.getCurrentUserData();
    if (user == null) {
      return left(Failure(message: 'User Not Logged In'));
    } else {
      return right(user);
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String otp}) async {
    try {
      if (await connectionChecker.isConnected) {
        // ignore: use_build_context_synchronously
        await authRemoteDataSource.verifyOtp(
            context: context, verificationId: verificationId, otp: otp);
        return Right(null);
      } else {
        throw "No Internet Connection";
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> loginWithPhoneNumber(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      if (await connectionChecker.isConnected) {
        authRemoteDataSource.signInWithPhoneNumber(
            // ignore: use_build_context_synchronously
            context: context,
            phoneNumber: phoneNumber);

        return right(null);
      } else {
        throw "No Internet Connection";
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> saveUserData(
      {required String name,
      required File? profilePic,
      required BuildContext context}) async {
    try {
      if (await connectionChecker.isConnected) {
        final user = await authRemoteDataSource.uploadUserData(
            // ignore: use_build_context_synchronously
            name: name,
            profilePic: profilePic,
            context: context);
        return right(user);
      } else {
        throw "No Internet Connection";
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
