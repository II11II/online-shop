import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:online_shop/exceptions/exceptions.dart';
import 'package:online_shop/model/products.dart';
import 'package:online_shop/repository/repository.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:easy_localization/easy_localization.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(Product product) : super(ProductState(product));
  final Repository repository = Repository();
  var log = Logger();
  void expandInstruction()=>
    emit(state.copyWith(isInstructionExpanded:!state.isInstructionExpanded ));

  void expandDescription() =>
      emit(state.copyWith(isDescriptionExpanded: !state.isDescriptionExpanded));

  buy()async{
    try{
      emit(state.copyWith(networkState: NetworkState.LOADING));
      await repository.createOrderCustomer(state.tournament);
      emit(state.copyWith(networkState: NetworkState.LOADED));
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

  likePress(Product product) async {
    try {
      emit(state.copyWith(networkState: NetworkState.LOADING));

      if (state.isLiked)
        await repository.removeFromFavorite(product.id);
      else
        await repository.addToFavorite(product);

      emit(state.copyWith(networkState: NetworkState.LOADED,isLiked:!state.isLiked ));

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
