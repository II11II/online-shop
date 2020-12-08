import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/model/products.dart';
import 'package:online_shop/ui/page/entry_point/entry_point.dart';
import 'package:online_shop/ui/page/match_page/match_cubit.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:online_shop/ui/style/color.dart';
import 'package:online_shop/ui/widget/custom_button.dart';
import 'package:online_shop/ui/widget/pop_up.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key key, this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  var isExpanded = false;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 1.0, end: 0.0).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var bloc = context.bloc<MatchCubit>();

    return Column(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: widget.product.mainImage,
              fit: BoxFit.cover,
              height: 250,
              width: size.width,
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2,
                ),
              ]),
            ),
            SafeArea(child: appBar(context)),
            Positioned(
              bottom: 5,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.product.price}'),
                  IconButton(
                    onPressed: () async => await bloc.likePress(widget.product),
                    icon: BlocConsumer<MatchCubit, MatchState>(
                        listenWhen: (p, c) => p.networkState != c.networkState,
                        listener: (context, state) {
                          if (state.networkState == NetworkState.LOADED ||
                              state.networkState == NetworkState.LOADING) {
                          } else if (state.networkState ==
                              NetworkState.INVALID_TOKEN) {
                            showMessage(context, state.message,
                                Icons.report_problem_outlined,
                                iconColor: Colors.red,
                                onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EntryPoint())));
                          } else {
                            showMessage(context, state.message,
                                Icons.report_problem_outlined,
                                iconColor: Colors.red);
                          }
                        },
                        builder: (context, MatchState state) {
                          if (state.networkState == NetworkState.LOADED &&
                              state.isLiked)
                            return Icon(
                              Icons.favorite,
                              color: Colors.red,
                            );
                          else if (state.networkState == NetworkState.LOADED &&
                              state.isLiked)
                            return Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            );
                          else if (state.networkState == NetworkState.LOADING)
                            return Container();
                          else {
                            if (state.isLiked)
                              return Icon(
                                Icons.favorite,
                                color: Colors.red,
                              );
                            else
                              return Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              );
                          }
                        }),
                  )
                ],
              ),
            )
          ],
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(context, 'description'.tr(),
                      () => bloc.expandDescription()),
                  BlocBuilder<MatchCubit, MatchState>(
                    builder: (context, MatchState state) => AnimatedCrossFade(
                      firstChild: Text(
                        '${bloc.state.tournament.description}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                        maxLines: 3,
                      ),
                      secondChild: Text(
                        '${bloc.state.tournament.description}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                      crossFadeState: !state.isDescriptionExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 500),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: Text(
                      'prizes'.tr(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Column(
                    children: [
                      if (bloc.state.tournament.oldPrice != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${"old_prize".tr()}: ${bloc.state.tournament.oldPrice}"),
                        ),
                      if (bloc.state.tournament.oldPrice != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${"new_prize".tr()}: ${bloc.state.tournament.price}"),
                        ),
                      if (bloc.state.tournament.oldPrice == null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${"prize".tr()}: ${bloc.state.tournament
                                  .oldPrice}"),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AnimatedCrossFade(
            firstChild: CustomButton(
              text: "get_ticket_now".tr(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.blueAccent, blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: BottomSheet(
                            enableDrag: true,
                            animationController: animationController,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )),
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: 8, right: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('get_ticket_now'.tr()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('total_payment'.tr()),
                                                FittedBox(child: Text('${bloc.state.tournament.price}'))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("${'payment_option'.tr()}: ${'cash'.tr()}"),
                                          ),

                                          CustomButton(
                                            text: 'buy_now'.tr(),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            onClosing: () {},
                          ),
                        ),
                      );
                    });
              },
            ),
            duration: Duration(seconds: 1),
            crossFadeState: CrossFadeState.showFirst,
            secondChild: Container(),
          ),
        )
      ],
    );
  }

  Widget _title(BuildContext context, String title, Function onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        FlatButton(
          child: Text(
            'more_info'.tr(),
            style: Theme.of(context).textTheme.button.copyWith(
                fontWeight: FontWeight.w700, color: ColorApp.blueAccent),
          ),
          onPressed: onPressed,
        )
      ],
    );
  }

  Widget appBar(BuildContext context) {
    var bloc = context.bloc<MatchCubit>();
    return Row(
      children: [
        Container(
          child: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${bloc.state.tournament.name}',
            style: TextStyle(),
          ),
        ))
      ],
    );
  }
}
