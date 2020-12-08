// import 'dart:io';
//
// import 'package:bloc/bloc.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:logger/logger.dart';
// import 'package:online_shop/exceptions/exceptions.dart';
// import 'package:online_shop/model/products.dart';
// import 'package:online_shop/repository/repository.dart';
// import 'package:online_shop/ui/state/network_state.dart';
//
// part 'tournaments_state.dart';
//
// class TournamentCubits extends Cubit<TournamentsState> {
//   TournamentCubits(Function getTournaments,{Products products})
//       : super(TournamentsState(getTournaments,tournaments: products));
//   final Repository repository = Repository();
//   var log = Logger();
//
//   Future init() async {
//     try {
//       emit(state.copyWith(networkState: NetworkState.LOADING,));
//       Products tournaments = await state.getTournaments();
//       log.d(tournaments);
//       emit(state.copyWith(
//           networkState: NetworkState.LOADED, tournaments: tournaments));
//     } on ServerErrorException catch (e) {
//       emit(state.copyWith(
//           message: "server_error".tr(),
//           networkState: NetworkState.SERVER_ERROR));
//
//       log.d(e);
//     } on InvalidTokenException catch (e) {
//       await repository.removeUserToken();
//       emit(state.copyWith(
//           message: "invalid_token".tr(),
//           networkState: NetworkState.INVALID_TOKEN));
//
//       log.d(e);
//     } on SocketException catch (e) {
//       emit(state.copyWith(
//           message: "no_connection".tr(),
//           networkState: NetworkState.NO_CONNECTION));
//
//       log.d(e);
//     } on Exception catch (e) {
//       emit(state.copyWith(
//           message: "unknown".tr(), networkState: NetworkState.UNKNOWN_ERROR));
//
//       log.d(e);
//     }
//   }
// }
