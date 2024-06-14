import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/error/failure.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/features/auth/domain/repository/auth_repository.dart';

class LoginParams {
  BuildContext context;
  String phoneNumber;

  LoginParams({required this.context, required this.phoneNumber});
}

class UserLogin implements UseCase<void, LoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, void>> call(LoginParams params) async {
     return await authRepository.loginWithPhoneNumber(
        context: params.context, phoneNumber: params.phoneNumber);
  }
}
