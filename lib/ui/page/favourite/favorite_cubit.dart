import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:online_shop/exceptions/exceptions.dart';
import 'package:online_shop/model/products.dart';
import 'package:online_shop/repository/repository.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';

part 'favorite_state.dart';

class FavoriteProductsCubit extends Cubit<FavoriteState> {
  FavoriteProductsCubit() : super(FavoriteState());
  final Repository repository = Repository();
  final log = Logger();

  Future getFavorites() async {
    try {
      emit(state.copyWith(state: NetworkState.LOADING));
      Products favoriteProducts = await repository.favoriteProducts();
      emit(state.copyWith(
          state: NetworkState.LOADED,
          favoriteProducts: favoriteProducts.object));
    } on ServerErrorException catch (e) {
      emit(state.copyWith(
          message: "server_error".tr(), state: NetworkState.SERVER_ERROR));

      log.d(e);
    } on InvalidTokenException catch (e) {
      await repository.removeUserToken();
      emit(state.copyWith(
          message: "invalid_token".tr(), state: NetworkState.INVALID_TOKEN));

      log.d(e);
    } on SocketException catch (e) {
      emit(state.copyWith(
          message: "no_connection".tr(), state: NetworkState.NO_CONNECTION));

      log.d(e);
    } on Exception catch (e) {
      emit(state.copyWith(
          message: "unknown_error".tr(), state: NetworkState.UNKNOWN_ERROR));

      log.d(e);
    }
  }
}
