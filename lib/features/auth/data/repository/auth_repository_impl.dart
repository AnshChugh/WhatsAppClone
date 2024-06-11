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
  Future<Either<Failure, User>> loginWithPhoneNumber(
      {required BuildContext context, required String phoneNumber}) {
    throw UnimplementedError();
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!(await connectionChecker.isConnected)) {
        return left(Failure(message: 'No Internet Connection'));
      }
      final user = await fn();
      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
