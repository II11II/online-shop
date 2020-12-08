import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:online_shop/ui/page/category/category_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_shop/ui/page/entry_point/entry_point.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:online_shop/ui/widget/match_card/match_card.dart';
import 'package:online_shop/ui/widget/no_connection.dart';
import 'package:online_shop/ui/widget/pop_up.dart';
class CategoryPage extends StatelessWidget {
  final String title;
  final int id;
   CategoryPage({Key key, this.title, this.id}) : super(key: key);

  final scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:BlocConsumer<CategoryCubit, CategoryState>(
          listener: (BuildContext context, state)  {
            if (state.networkState== NetworkState.LOADING) {

              showLoading(context);
            } else if (state.networkState== NetworkState.LOADED) {
              // if (Navigator.of(context, rootNavigator: true).canPop())
              //   Navigator.of(context, rootNavigator: true).pop();
            } else if (state.networkState== NetworkState.SERVER_ERROR) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red);
            } else if (state.networkState== NetworkState.INVALID_TOKEN) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
              showMessage(context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red,
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EntryPoint())));
            } else if (state.networkState== NetworkState.NO_CONNECTION) {
              if (Navigator.of(context, rootNavigator: true).canPop())
                Navigator.of(context, rootNavigator: true).pop();
               showMessage(
                  context, state.message, Icons.report_problem_outlined,
                  iconColor: Colors.red);
            }
          }, builder: (context, state) {
        if (state.networkState== NetworkState.LOADED)
          return body(context);

        else if (state.networkState== NetworkState.NO_CONNECTION)
          return NoConnection(
            onPressed: () async =>
            await context.bloc<CategoryCubit>().getProductByCategory(id),
          );
        else
          return RefreshIndicator(
              onRefresh: () async =>
              await context.bloc<CategoryCubit>().getProductByCategory(id),
              child: ListView());
      }),
    );
  }

  Widget body(BuildContext context) {

    var bloc = context.bloc<CategoryCubit>();
    return RefreshIndicator(
      onRefresh: () async=>await bloc.getProductByCategory(id),
      child: GridView.builder(
        controller: scrollController..addListener(()async {
          if(scrollController.offset==scrollController.position.maxScrollExtent)
            await bloc.getProductByCategory(id);
        }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.3),
          shrinkWrap: true,
          itemCount: bloc.state.newProducts.length,
          itemBuilder: (context, index) {
            return FittedBox(
                child: MatchCard(
                  product: bloc.state.newProducts[index],
                  // buttonTitle: "ticket".tr(),
                  onPressed: () {
                    var info=bloc.state.newProducts[index];
                    // showTicket(context,info.,"${info.quantity}","${info.totalPrice}");
                  },
                ));
          }),
    );
  }
}
