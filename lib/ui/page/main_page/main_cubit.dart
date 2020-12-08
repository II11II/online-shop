import 'package:bloc/bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial(0));
  void changePage(int index) {
    emit(MainInitial(index));
  }
}
