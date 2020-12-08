import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/ui/page/home_page/home_cubit.dart';
import 'package:online_shop/ui/page/home_page/home_page.dart';
import 'package:online_shop/ui/page/my_orders_page/my_orders_cubit.dart';
import 'package:online_shop/ui/page/my_orders_page/my_orders_page.dart';
import 'package:online_shop/ui/page/profile_page/profile_cubit.dart';
import 'package:online_shop/ui/page/profile_page/profile_page.dart';
import 'package:online_shop/ui/widget/bottom_nav_bar.dart';

import 'main_cubit.dart';

class MainPage extends StatelessWidget {
  final _kTabPages = <Widget>[
    BlocProvider(
        create: (BuildContext context) => HomeCubit()..init(),
        child: HomePage()),
    BlocProvider(
        create: (BuildContext context) => MyOrdersCubit()..getCustomerOrders(),
        child: MyOrdersPage()),
    BlocProvider(
        create: (BuildContext context) => ProfileCubit()..init(),
        child: ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
        // return _kTabPages[state.index];
        return IndexedStack(
          children: _kTabPages,
          index: state.index,
        );
      }),
    );
  }
}
