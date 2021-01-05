import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/ui/page/entry_point/entry_point.dart';
import 'package:online_shop/ui/page/favourite/favorite_cubit.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:online_shop/ui/widget/match_card/match_card.dart';
import 'package:online_shop/ui/widget/no_connection.dart';
import 'package:online_shop/ui/widget/pop_up.dart';

class FavoriteProductsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var bloc=context.bloc<FavoriteProductsCubit>();


    return Scaffold(
      appBar: AppBar(
        title: Text('favorite_products'.tr()),
      ),
      body:  BlocConsumer<FavoriteProductsCubit, FavoriteState>(
        cubit: bloc..getFavorites(),

          listener: (BuildContext context, state) async {

            if (state.state == NetworkState.LOADING) {
             await showLoading(context);
            } else if (state.state == NetworkState.LOADED) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
            } else if (state.state == NetworkState.SERVER_ERROR) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red);
            } else if (state.state == NetworkState.INVALID_TOKEN) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red,
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EntryPoint())));
            } else if (state.state == NetworkState.NO_CONNECTION) {
              // if (Navigator.of(context, rootNavigator: true).canPop())
              //   Navigator.of(context, rootNavigator: true).pop();
              await showMessage(
                  context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red);
            }
          }, builder: (context, state) {
        if (state.state == NetworkState.LOADED)
          return body(context);

        else if (state.state == NetworkState.NO_CONNECTION)
          return NoConnection(
            onPressed: () async =>
            await context.bloc<FavoriteProductsCubit>().getFavorites(),
          );
        else
          return RefreshIndicator(
              onRefresh: () async =>
              await context.bloc<FavoriteProductsCubit>().getFavorites(),
              child: ListView());
      }),
      // floatingActionButton: fab(context),
    );
  }



  Widget body(BuildContext context) {
    var bloc = context.bloc<FavoriteProductsCubit>();
    return RefreshIndicator(
      onRefresh: () async=>await bloc.getFavorites(),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.3),
          shrinkWrap: true,
          itemCount: bloc.state.favoriteProducts.length,
          itemBuilder: (context, index) {
            return FittedBox(
                child: MatchCard(
                  product: bloc.state.favoriteProducts[index],
                  buttonTitle: "ticket".tr(),
                  onPressed: () {
                    var info=bloc.state.favoriteProducts[index];
                    // showTicket(context,info.statusForOrder,"${info.quantity}","${info.totalPrice}");
                  },
                ));
          }),
    );
  }
}
