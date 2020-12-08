part of 'profile_cubit.dart';

class ProfileState {
  Profile profile;
  NetworkState state;
  String message;

  ProfileState({this.profile, this.state=NetworkState.INITIAL, this.message});

  ProfileState copyWith(
      { Profile profile , String message, NetworkState state}) {
    return ProfileState(
        profile: profile ?? this.profile,
        state: state ?? this.state,
        message: message ?? this.message);
  }
}
