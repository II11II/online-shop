import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/ui/page/entry_point/entry_point.dart';
import 'package:online_shop/ui/page/favourite/favorite_cubit.dart';
import 'package:online_shop/ui/page/favourite/favorite_page.dart';
import 'package:online_shop/ui/page/my_orders_page/my_orders_cubit.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:online_shop/ui/widget/match_card/match_card.dart';
import 'package:online_shop/ui/widget/no_connection.dart';
import 'package:online_shop/ui/widget/pop_up.dart';

class MyOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_tickets'.tr()),
      ),
      body: BlocConsumer<MyOrdersCubit, MyTicketsState>(
          listener: (BuildContext context, state) async {
        if (state.state == NetworkState.INITIAL) {
          await context.bloc<MyOrdersCubit>().getCustomerOrders();
        }
        if (state.state == NetworkState.LOADING) {
          showLoading(context);
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
          if (Navigator.of(context, rootNavigator: true).canPop())
            Navigator.of(context, rootNavigator: true).pop();
          await showMessage(
              context, state.message, Icons.report_problem_outlined,
              iconColor: Colors.red);
        }
      }, builder: (context, state) {
        if (state.state == NetworkState.LOADED)
          return body(context);
        // TODO: Delete Container after be ready  api
        // return Container();
        else if (state.state == NetworkState.NO_CONNECTION)
          return NoConnection(
            onPressed: () async =>
                await context.bloc<MyOrdersCubit>().getCustomerOrders(),
          );
        else
          return RefreshIndicator(
              onRefresh: () async =>
                  await context.bloc<MyOrdersCubit>().getCustomerOrders(),
              child: ListView());
      }),
      floatingActionButton: fab(context),
    );
  }

  Widget fab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => BlocProvider(
                  create: (BuildContext context) =>
                      FavoriteProductsCubit(),
                  child: FavoriteProductsPage()))),
      child: Icon(Icons.favorite),
    );
  }

  Widget body(BuildContext context) {
    var bloc = context.bloc<MyOrdersCubit>();
    return RefreshIndicator(
      onRefresh: () async => await bloc.getCustomerOrders(),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.3),
          shrinkWrap: true,
          itemCount: bloc.state.customerOrders.object.length,
          itemBuilder: (context, index) {
            return FittedBox(
                child: MatchCard(
              product: bloc.state.customerOrders.object[index].product,
              buttonTitle: "ticket".tr(),
              onPressed: () {
                var info = bloc.state.customerOrders.object[index];
                showTicket(context, info.statusForOrder, "${info.quantity}",
                    "${info.totalPrice}");
              },
            ));
          }),
    );
  }
}
