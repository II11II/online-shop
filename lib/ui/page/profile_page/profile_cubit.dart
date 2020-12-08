import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:online_shop/model/profile.dart';
import 'package:online_shop/repository/repository.dart';
import 'package:online_shop/ui/state/network_state.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  final Repository repository = Repository();
  final log = Logger();

  Future init() async {
    emit(state.copyWith(profile: await repository.getUser()));
  }
}
