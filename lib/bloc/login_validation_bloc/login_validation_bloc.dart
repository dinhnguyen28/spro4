import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:login_bloc/api/api_service.dart';

import 'package:login_bloc/models/login_model/login_models.dart';
import 'package:formz/formz.dart';
import 'package:login_bloc/models/storage_item_model/storage_item.dart';

import '../../main.dart';

part 'login_validation_event.dart';
part 'login_validation_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<Submitted>(_onSubmitted);
    on<Test>(_onTest);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> _onSubmitted(Submitted event, Emitter<LoginState> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(authStatus: AuthStatus.initial));

    if (state.status.isValid) {
      final responseData = (await loginRequest(LoginRequest(
        email: email.value,
        password: password.value,
      )));

      if (responseData.code == 1) {
        await secureStorage.writeSecureData(StorageItem(
            'accessToken', responseData.data!.accessToken.toString()));

        emit(state.copyWith(
          authStatus: AuthStatus.success,
        ));
      } else if (responseData.code == -3) {
        emit(state.copyWith(
          message: responseData.message,
          authStatus: AuthStatus.failure,
        ));
      } else {
        emit(state.copyWith(
          message: 'Không thể đăng nhập',
          authStatus: AuthStatus.failure,
        ));
      }
    } else if (email.value.isEmpty && password.value.isEmpty) {
      emit(state.copyWith(
        message: 'Vui lòng nhập Email và Password',
        authStatus: AuthStatus.failure,
      ));
    }
  }

  Future<void> _onTest(Test event, Emitter<LoginState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.initial));
    final responseData = (await loginRequest(LoginRequest(
      email: 'shippertest0001@gmail.com',
      password: '1234@Fis',
    )));

    if (responseData.code == 1) {
      await secureStorage.writeSecureData(StorageItem(
          'accessToken', responseData.data!.accessToken.toString()));
      emit(state.copyWith(authStatus: AuthStatus.success));
    }
  }
}
