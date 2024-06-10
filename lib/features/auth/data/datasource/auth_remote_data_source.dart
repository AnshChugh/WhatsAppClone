import 'package:whatsapp_clone/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signInWithPhoneNumber({required String phoneNumber});

  Future<UserModel?> getCurrentUserData();
}
