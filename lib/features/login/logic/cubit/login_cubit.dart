import 'package:doctor_booking_app/core/networking/api_result.dart';
import 'package:doctor_booking_app/features/login/data/models/login_request_body.dart';
import 'package:doctor_booking_app/features/login/data/repos/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_app/features/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final fromKey = GlobalKey<FormState>();

  void emitLoginStates(LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loading());
    
    final response = await _loginRepo.login(loginRequestBody);

    response.when(
      success: (LoginResponse) {
        emit(LoginState.success(LoginResponse));
      },
      failure: (error) {
        emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
