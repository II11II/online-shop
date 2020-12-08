import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/model/get_category_model.dart';
import 'package:online_shop/ui/page/category/category_cubit.dart';
import 'package:online_shop/ui/page/category/category_page.dart';

import 'package:online_shop/ui/widget/premium_card.dart';

class AllCategoriesPage extends StatelessWidget {
  final GetCategory categories;

  const AllCategoriesPage({
    Key key,
    this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("category".tr()),
      ),
      body:   body(context)
      // BlocConsumer<AllCategoriesCubit, AllCategoriesState>(
      //   listener: (BuildContext context, state) async {
      //     if (state.networkState == NetworkState.LOADING) {
      //       showLoading(context);
      //     } else if (state.networkState == NetworkState.LOADED) {
      //       // if (Navigator.of(context, rootNavigator: true, ).canPop())
      //       //   Navigator.of(context, rootNavigator: true).pop();
      //     } else if (state.networkState == NetworkState.INVALID_TOKEN) {
      //       if (Navigator.of(context, rootNavigator: true).canPop())
      //         Navigator.of(context, rootNavigator: true).pop();
      //       showMessage(context, state.message, Icons.report_problem_outlined,
      //           iconColor: Colors.red,
      //           onPressed: () => Navigator.pushReplacement(context,
      //               MaterialPageRoute(builder: (context) => EntryPoint())));
      //     } else {
      //       if (Navigator.of(context, rootNavigator: true).canPop())
      //         Navigator.of(context, rootNavigator: true).pop();
      //       await showMessage(
      //           context, state.message, Icons.report_problem_outlined,
      //           iconColor: Colors.red);
      //     }
      //   },
      //   builder: (context, state) {
      //     if (state.networkState == NetworkState.LOADED)
      //       return body(context);
      //     else if (state.networkState == NetworkState.NO_CONNECTION)
      //       return NoConnection(
      //         onPressed: context.bloc<AllCategoriesCubit>().init,
      //       );
      //     else
      //       return Container();
      //   },
      // ),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: categories.object.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: PremiumCard(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                     return   BlocProvider(
                            create: (BuildContext
                            context) =>
                            CategoryCubit()
                              ..getProductByCategory(
                                  categories
                                      .object[index]
                                      .id),
                            child: CategoryPage(
                              title:
                              "${categories.object[index].name}",
                              id: categories
                                  .object[index].id,
                            ));

                  }));
                },
                category: categories.object[index],
              ),
            ),
          );
        },

      ),
    );
  }
}
