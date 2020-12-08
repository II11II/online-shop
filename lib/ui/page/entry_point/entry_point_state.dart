part of 'entry_point_cubit.dart';

abstract class EntryPointState  {
  const EntryPointState();
}

class EntryPointSplash extends EntryPointState {
  const EntryPointSplash();

}
class EntryPointAuthenticated extends EntryPointState {
  const EntryPointAuthenticated();

}
class EntryPointNotAuthenticated extends EntryPointState {
  const EntryPointNotAuthenticated();

}
