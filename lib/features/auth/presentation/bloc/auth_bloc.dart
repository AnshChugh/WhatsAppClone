import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/common/cubit/app_user_cubit_cubit.dart';
import 'package:whatsapp_clone/core/common/entities/user.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/current_user.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/save_user_data.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/user_login.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/verify_otp.dart';
import 'package:whatsapp_clone/features/auth/presentation/screens/user_information_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogIn;
  final CurrentUser _currentUser;
  final UserVerifyOtp _verifyOtp;
  final SaveUserData _saveUserData;

  final AppUserCubitCubit _appUserCubit;
  AuthBloc(
      {required UserLogin userLogin,
      required CurrentUser currentUser,
      required UserVerifyOtp userVerifyOtp,
      required SaveUserData saveUserData,
      required AppUserCubitCubit appUserCubit})
      : _userLogIn = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _verifyOtp = userVerifyOtp,
        _saveUserData = saveUserData,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthLogin>(_onAuthLogin);
    on<AuthVerifyOtp>(_onAuthVerifyOtp);
    on<AuthUploadUserData>(_onAuthUploadUserData);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }


  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await _userLogIn(
        LoginParams(context: event.context, phoneNumber: event.phoneNumber));

    response.fold((l) => emit(AuthFailure(message: l.message)), (r) {
      print('success');
    });
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => _emitAuthSucess(user, emit));
  }

  void _onAuthVerifyOtp(AuthVerifyOtp event, Emitter<AuthState> emit) async {
    final res = await _verifyOtp(VerifyOtpParams(
        context: event.context,
        verifcationId: event.verificationId,
        otp: event.otp));
    res.fold((l) => emit(AuthFailure(message: l.message)), (_) {
      Navigator.pushReplacement(event.context,
          MaterialPageRoute(builder: (_) => const UserInformationScreen()));
    });
  }

  void _onAuthUploadUserData(
      AuthUploadUserData event, Emitter<AuthState> emit) async {
    final res = await _saveUserData(
        SaveDataParams(event.name, event.profilePic, event.context));
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => _emitAuthSucess(user,emit));
  }

  void _emitAuthSucess(User user, Emitter<AuthState> emit) {
    emit(AuthSucess(user: user));
    _appUserCubit.updateUser(user);
  }
}
