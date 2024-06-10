import 'package:whatsapp_clone/core/common/entities/user.dart';
import 'package:whatsapp_clone/core/error/failure.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/features/auth/domain/repository/auth_repository.dart';

class LoginParams {
  String phoneNumber;
  LoginParams({required this.phoneNumber});
}

class UserLogin implements UseCase<User, LoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.loginWithPhoneNumber(
        phoneNumber: params.phoneNumber);
  }
}
