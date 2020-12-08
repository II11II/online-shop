import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:online_shop/exceptions/exceptions.dart';
import 'package:online_shop/model/get_category_model.dart';
import 'package:online_shop/model/products.dart';
import 'package:online_shop/repository/repository.dart';
import 'package:online_shop/ui/state/network_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  var log = Logger();
  final Repository repository = Repository();

  Future logout() async {
    try {
      await repository.removeUserToken();
      await repository.removeUser();


      emit(state.copyWith(logout: true));
    } on ServerErrorException {
      emit(state.copyWith(logout: false));
    } on Exception {
      emit(state.copyWith(logout: false));
    }
  }

  Future<GetCategory> getCategories() async {
    GetCategory categories = await repository.getCategories();
    log.d("categories: ${categories.object.length}");
    return categories;
  }

  Future<List<Product>> getNewProducts() async {
    Products todayTournaments = await repository.getPopularProducts();

    return todayTournaments.object;
  }

  // Future<List<Tournament>> getUpcomingTournaments() async {
  //   List<Tournament> upcomingTournaments =
  //       await repository.upcomingTournaments();
  //   return upcomingTournaments;
  // }

  Future init() async {
    emit(state.copyWith(networkState: NetworkState.LOADING));
    try {
      GetCategory categories=await getCategories();
      List<Product> products=await getNewProducts();
      emit(state.copyWith(
          networkState: NetworkState.LOADED,
          newProducts: products,
          // upcomingTournaments: await getUpcomingTournaments(),
          getCategories:categories ));
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
