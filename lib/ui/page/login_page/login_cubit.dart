import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:online_shop/exceptions/exceptions.dart';
import 'package:online_shop/model/profile.dart';
import 'package:online_shop/repository/repository.dart';
import 'package:online_shop/ui/state/network_state.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
  final Repository repository = Repository();
  final loginField = TextEditingController();
  final passwordField = TextEditingController();

  Future login() async {
    try {
      emit(LoginState.copyWith(state, networkState: NetworkState.LOADING));

      Profile profile =
          await repository.login(loginField.text, passwordField.text);
      await repository.saveUserToken(profile.token);
      await repository.saveUser(profile);

      emit(LoginState.copyWith(state, networkState: NetworkState.LOADED));
    } on InvalidLoginPasswordException catch (e) {
      print(e);
      emit(LoginState.copyWith(state,
          networkState: NetworkState.INVALID_CREDENTIALS,
          message: "invalid_credentials".tr()));
    } on ServerErrorException catch (e) {
      print(e);

      emit(LoginState.copyWith(state,
          networkState: NetworkState.SERVER_ERROR,
          message: "server_error".tr()));
    } on SocketException catch (e) {
      print(e);

      emit(LoginState.copyWith(state,
          networkState: NetworkState.INVALID_CREDENTIALS,
          message: "no_connection".tr()));
    } on Exception catch (e) {
      print(e);

      emit(LoginState.copyWith(state,
          networkState: NetworkState.INVALID_CREDENTIALS,
          message: "unknown_error".tr()));
    }
  }

  String loginFieldValidator(String text) {
    loginActivate();
    if (text.isNotEmpty) {
      return null;
    } else {
      return 'login_validation_info.length'.tr();
    }
  }

  String passwordFieldValidator(String password) {
    loginActivate();
    if (password.isNotEmpty)
      return null;
    else
      return "password_validation_info.non_empty".tr();
  }

  void loginActivate() {
    if (loginField.text.isNotEmpty
        //  &&
        //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(passwordField.text)
        )
      emit(LoginState.copyWith(state, isButtonActive: true));
    else
      emit(LoginState.copyWith(state, isButtonActive: false));
  }
}
