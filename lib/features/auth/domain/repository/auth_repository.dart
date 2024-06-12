import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/core/common/entities/user.dart';
import 'package:whatsapp_clone/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, void>> loginWithPhoneNumber(
      {required BuildContext context, required String phoneNumber});

  Future<Either<Failure, void>> verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String otp});

  Future<Either<Failure, User>> currentUser();
}
