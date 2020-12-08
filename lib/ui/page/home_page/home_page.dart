

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/ui/page/category/category_cubit.dart';
import 'package:online_shop/ui/page/category/category_page.dart';
import 'package:online_shop/ui/page/entry_point/entry_point.dart';
import 'package:online_shop/ui/page/all_categories_page/all_categories_page.dart';
import 'package:online_shop/ui/page/home_page/home_cubit.dart';
import 'package:online_shop/ui/page/match_page/match_cubit.dart';
import 'package:online_shop/ui/page/match_page/match_page.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:online_shop/ui/style/color.dart';
import 'package:online_shop/ui/style/style.dart';
import 'package:online_shop/ui/widget/match_card/match_card.dart';
import 'package:online_shop/ui/widget/no_connection.dart';
import 'package:online_shop/ui/widget/pop_up.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(context),
      body: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.networkState == NetworkState.LOADED)
            return _body(context);
          else if (state.networkState == NetworkState.NO_CONNECTION)
            return NoConnection(
              onPressed: () async => await context.bloc<HomeCubit>().init(),
            );
          else
            return Container();
        },
        listener: (BuildContext context, state) async {
          if (state.networkState == NetworkState.LOADING) {
            showLoading(context);
          } else if (state.networkState == NetworkState.LOADED) {
            if (Navigator.of(context, rootNavigator: true).canPop())
              Navigator.of(context, rootNavigator: true).pop();
          } else if (state.networkState == NetworkState.SERVER_ERROR) {
            if (Navigator.of(context, rootNavigator: true).canPop())
              Navigator.of(context, rootNavigator: true).pop();
            showMessage(context, state.message, Icons.report_problem_outlined,
                iconColor: Colors.red);
          } else if (state.networkState == NetworkState.INVALID_TOKEN) {
            if (Navigator.of(context, rootNavigator: true).canPop())
              Navigator.of(context, rootNavigator: true).pop();
            showMessage(context, state.message, Icons.report_problem_outlined,
                iconColor: Colors.red,
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => EntryPoint())));
          } else if (state.networkState == NetworkState.NO_CONNECTION) {
            if (Navigator.of(context, rootNavigator: true).canPop())
              Navigator.of(context, rootNavigator: true).pop();
            await showMessage(
                context, state.message, Icons.report_problem_outlined,
                iconColor: Colors.red);
          }
        },
      ),
      appBar: _appBar(context),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        leading: Container(),
        title: Text('home_page'.tr()),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(FeatherIcons.alignRight),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          })
        ],
      );

  var scrollPhysics=BouncingScrollPhysics();
  Widget _body(BuildContext context) {
    var bloc = context.bloc<HomeCubit>();
    var size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        await bloc.init();
      },
      child: ListView(physics: scrollPhysics,
        shrinkWrap: true,
        children: [
          if (bloc.state.getCategories.object.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(context, "category".tr(),
                        BlocProvider.value(value: bloc, child: AllCategoriesPage(categories:bloc.state.getCategories))),
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      height: 150,
                      // width: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bloc.state.getCategories.object.length < 10
                              ? bloc.state.getCategories.object.length
                              : 10,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            BlocProvider(
                                                create: (BuildContext
                                                        context) =>
                                                    CategoryCubit()
                                                      ..getProductByCategory(
                                                          bloc
                                                              .state
                                                              .getCategories
                                                              .object[index]
                                                              .id),
                                                child: CategoryPage(
                                                  title:
                                                      "${bloc.state.getCategories.object[index].name}",
                                                  id: bloc.state.getCategories
                                                      .object[index].id,
                                                ))));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage:
                                          CachedNetworkImageProvider(bloc
                                              .state
                                              .getCategories
                                              .object[index]
                                              .imageCategory),

                                      // tournament: bloc.state.getCategories.object[index],
                                      // onPressed: () => Navigator.push(
                                      //     context,
                                      //     CupertinoPageRoute(
                                      //         builder: (c) => BlocProvider(
                                      //             create: (BuildContext context) =>
                                      //                 MatchCubit(bloc
                                      //                     .state.getCategories.object[index]),
                                      //             child: MatchPage()
                                      //         ))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(bloc.state.getCategories
                                        .object[index].name),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          // PremiumCard(
          //   onPressed: () => Navigator.push(
          //       context,
          //       CupertinoPageRoute(
          //           builder: (BuildContext c) => BlocProvider<MatchCubit>(
          //               create: (context) =>
          //                   MatchCubit(bloc.state.getCategories[0]),
          //               child: MatchPage()))),
          // ),
          if (bloc.state.newProducts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("new_products".tr()),
                    // _title(context, 'today'.tr(), Text('')
                    //     // BlocProvider<TournamentCubits>(
                    //     //     create: (BuildContext context) =>
                    //     //         TournamentCubits(bloc.getTodayTournaments)..init(),
                    //     //     child: TournamentsPage(appBarTitle: 'today'.tr()))
                    //     ),
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      height: 400,
                      width: size.width,
                      child: GridView.builder(
                        physics: scrollPhysics,
                        itemCount: bloc.state.newProducts.length < 10
                            ? bloc.state.newProducts.length
                            : 10,
                        itemBuilder: (context, index) {
                          return FittedBox(
                            child: MatchCard(
                                product: bloc.state.newProducts[index],
                                onPressed:
                                () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (c) =>
                                          BlocProvider(
                                          create: (BuildContext context) =>
                                              MatchCubit( bloc.state.newProducts[index]
                                                ),
                                          child: ProductPage(product: bloc.state.newProducts[index],))
                                    )
                                ),
                                )
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / 1.3),
                      ),
                    ),
                  ]),
            )
          // if (bloc.state.upcomingTournaments.isNotEmpty)
          //   _title(
          //       context,
          //       'upcoming'.tr(),
          //       BlocProvider(
          //           create: (BuildContext context) =>
          //               TournamentCubits(bloc.getUpcomingTournaments)..init(),
          //           child: TournamentsPage(appBarTitle: 'upcoming'.tr()))),
          // if (bloc.state.upcomingTournaments.isNotEmpty)
          //   Container(
          //     height: 252,
          //     width: 150,
          //     child: ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         itemCount: bloc.state.upcomingTournaments.length < 10
          //             ? bloc.state.upcomingTournaments.length
          //             : 10,
          //         itemBuilder: (context, index) {
          //           return MatchCard(
          //             tournament: bloc.state.upcomingTournaments[index],
          //             onPressed: () => Navigator.push(
          //                 context,
          //                 CupertinoPageRoute(
          //                     builder: (c) => BlocProvider(
          //                         create: (context) => MatchCubit(
          //                             bloc.state.upcomingTournaments[index]),
          //                         child: MatchPage()))),
          //           );
          //         }),
          //   ),
        ],
      ),
    );
  }

  Widget _title(BuildContext context, String title, Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        FlatButton(
          child: Text(
            'view_all'.tr(),
            style: Style.defaultText.copyWith(
                fontWeight: FontWeight.w700, color: ColorApp.blueAccent),
          ),
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (BuildContext context) {
              return child;
            }));
          },
        )
      ],
    );
  }

  Widget _drawer(BuildContext context) {
    var bloc = context.bloc<HomeCubit>();
    return Drawer(
      child: Container(
        color: ColorApp.drawerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: DrawerHeader(
                child: FittedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/logo.png"),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'pubg_arena'.tr(),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Color(0xff010101), Color(0xff1b1b1b)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pop();

                        showLocalization(
                          context,
                        );
                      },
                      leading: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: Text(
                        'language'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Color(0xff010101), Color(0xff1b1b1b)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                    child: ListTile(
                      onTap: () async {
                        /// TODO : link to play market and app store
                        // LaunchReview.launch(androidAppId: "com.iyaffle.rangoli",
                        //     iOSAppId: "585027354");
                      },
                      leading: Icon(
                        Icons.star_border,
                        color: Colors.white,
                      ),
                      title: Text(
                        'rate_app'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Color(0xff010101), Color(0xff1b1b1b)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pop();

                        showInfo(context);
                      },
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        'info'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Color(0xff010101), Color(0xff1b1b1b)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                    child: BlocListener<HomeCubit, HomeState>(
                      listener: (BuildContext context, state) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EntryPoint()));
                      },
                      listenWhen: (p, c) => p.logout != c.logout,
                      child: ListTile(
                        onTap: () async => context.bloc<HomeCubit>().logout(),
                        leading: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        title: Text(
                          'logout'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/future_development_logo.png'),
            )
          ],
        ),
      ),
    );
  }
}
