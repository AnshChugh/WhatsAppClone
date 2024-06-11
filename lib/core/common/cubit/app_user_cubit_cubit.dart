import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/common/entities/user.dart';

part 'app_user_cubit_state.dart';

class AppUserCubitCubit extends Cubit<AppUserCubitState> {
  AppUserCubitCubit() : super(AppUserCubitInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserCubitInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
