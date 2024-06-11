
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/core/common/cubit/app_user_cubit_cubit.dart';
import 'package:whatsapp_clone/core/common/entities/user.dart';
import 'package:whatsapp_clone/core/usecase/usecase.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/current_user.dart';
import 'package:whatsapp_clone/features/auth/domain/usecases/user_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogIn;
  final CurrentUser _currentUser;
  final AppUserCubitCubit _appUserCubit;
  AuthBloc(
      {
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubitCubit appUserCubit})
      :
       _userLogIn = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await _userLogIn(
        LoginParams(context: event.context, phoneNumber:event.phoneNumber ));

    response.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => _emitAuthSucess(user, emit));
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => _emitAuthSucess(user, emit));
  }

  void _emitAuthSucess(User user, Emitter<AuthState> emit) {
    emit(AuthSucess(user: user));
    _appUserCubit.updateUser(user);
  }
}
