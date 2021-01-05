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
   Profile profile= await repository.getUser();
    log.d(profile.email);
    log.d(profile.username);
    log.d(profile.password);
    log.d(profile.token);
    log.d(profile.date);
    emit(state.copyWith(profile:profile));
  }
}
