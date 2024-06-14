import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/error/failure.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/features/auth/domain/repository/auth_repository.dart';

class VerifyOtpParams {
  BuildContext context;
  final String otp;
  final String verifcationId;
  VerifyOtpParams(
      {required this.context, required this.verifcationId, required this.otp});
}

class UserVerifyOtp implements UseCase<void, VerifyOtpParams> {
  final AuthRepository authRepository;
  UserVerifyOtp(this.authRepository);
  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) {
    return authRepository.verifyOtp(
        context: params.context,
        verificationId: params.verifcationId,
        otp: params.otp);
  }
}
