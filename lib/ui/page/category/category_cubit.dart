import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:online_shop/exceptions/exceptions.dart';
import 'package:online_shop/model/products.dart';
import 'package:online_shop/repository/repository.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState());
  final log = Logger();
  final repository = Repository();

  Future getProductByCategory(int id, {int page}) async {
    emit(state.copyWith(
      networkState: NetworkState.LOADING,
    ));
    try {
      Products products = await repository.getProductsByCategory(id, page ?? 0);
      if (state.newProducts == null || state.newProducts.isEmpty)
        state.newProducts = products.object;
      else
        state.newProducts..addAll(products.object);
      emit(state.copyWith(
        networkState: NetworkState.LOADED,
      ));
      log.d(products.statusCode);
    } on ServerErrorException catch (e) {
      emit(state.copyWith(
          message: "server_error".tr(),
          networkState: NetworkState.SERVER_ERROR));

      log.d(e);
    } on InvalidTokenException catch (e) {
      await repository.removeUserToken();
      emit(state.copyWith(
          message: "invalid_token".tr(),
          networkState: NetworkState.INVALID_TOKEN));

      log.d(e);
    } on SocketException catch (e) {
      emit(state.copyWith(
          message: "no_connection".tr(),
          networkState: NetworkState.NO_CONNECTION));

      log.d(e);
    } on Exception catch (e) {
      emit(state.copyWith(
          message: "unknown_error".tr(),
          networkState: NetworkState.UNKNOWN_ERROR));

      log.d(e);
    }
  }
}
