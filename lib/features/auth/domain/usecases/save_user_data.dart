import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/src/either.dart';
import 'package:whatsapp_clone/core/common/entities/user.dart';
import 'package:whatsapp_clone/core/error/failure.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/auth/domain/repository/auth_repository.dart';

class SaveDataParams {
  final String name;
  final File? profilePic;
  final BuildContext context;
  SaveDataParams(this.name, this.profilePic, this.context);
}

class SaveUserData implements UseCase<User, SaveDataParams> {
  final AuthRepository authRepository;
  SaveUserData(this.authRepository);
  @override
  Future<Either<Failure, User>> call(SaveDataParams params) async {
    return await authRepository.saveUserData(
        name: params.name,
        profilePic: params.profilePic,
        context: params.context);
  }
}
