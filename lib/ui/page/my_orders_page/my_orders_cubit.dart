import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:online_shop/exceptions/exceptions.dart';
import 'package:online_shop/model/customer_orders_model.dart';
import 'package:online_shop/repository/repository.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';
part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyTicketsState> {
  MyOrdersCubit() : super(MyTicketsState());
  final Repository repository = Repository();
  final log=Logger();
  Future getCustomerOrders() async {
    try {
      emit(state.copyWith(state: NetworkState.LOADING));
      CustomerOrder customerOrders = await repository.getCustomerOrders();
      emit(state.copyWith(state: NetworkState.LOADED,customerOrders: customerOrders));

    }
    on ServerErrorException catch (e) {
      emit(state.copyWith(
          message: "server_error".tr(),
          state: NetworkState.SERVER_ERROR));

      log.d(e);
    } on InvalidTokenException catch (e) {
      await repository.removeUserToken();
      emit(state.copyWith(
          message: "invalid_token".tr(),
          state: NetworkState.INVALID_TOKEN));

      log.d(e);
    } on SocketException catch (e) {
      emit(state.copyWith(
          message: "no_connection".tr(),
          state: NetworkState.NO_CONNECTION));

      log.d(e);
    } on Exception catch (e) {
      emit(state.copyWith(
          message: "unknown_error".tr(), state: NetworkState.UNKNOWN_ERROR));

      log.d(e);
    }
  }
}
