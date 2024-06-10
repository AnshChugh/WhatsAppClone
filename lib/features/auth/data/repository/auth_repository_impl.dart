import 'package:whatsapp_clone/core/common/entities/user.dart';
import 'package:whatsapp_clone/core/error/failure.dart';
import 'package:whatsapp_clone/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:whatsapp_clone/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

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
      {required String phoneNumber}) {

    // TODO: Implement it.
    throw UnimplementedError();
  }
}
