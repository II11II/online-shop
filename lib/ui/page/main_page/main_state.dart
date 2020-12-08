part of 'main_cubit.dart';


abstract class MainState {
  final int index;
  const MainState(this.index);

}

class MainInitial extends MainState {
  final int index;
  const MainInitial(this.index):super(index);


}
