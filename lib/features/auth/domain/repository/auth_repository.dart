import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/core/common/entities/user.dart';
import 'package:whatsapp_clone/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithPhoneNumber(
      {required String phoneNumber});

  Future<Either<Failure, User?>> currentUser();
}
