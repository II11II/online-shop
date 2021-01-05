import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/ui/page/entry_point/entry_point.dart';
import 'package:online_shop/ui/page/map/map.dart';
import 'package:online_shop/ui/page/profile_page/profile_cubit.dart';
import 'package:online_shop/ui/state/network_state.dart';
import 'package:online_shop/ui/style/style.dart';
import 'package:online_shop/ui/widget/custom_button.dart';
import 'package:online_shop/ui/widget/no_connection.dart';
import 'package:online_shop/ui/widget/pop_up.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: body(context),

    );
  }

  Widget body(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var bloc = context.bloc<ProfileCubit>();

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            width: size.width,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xff3B0BFE))),
                      child: CircleAvatar(
                        child: Icon(Icons.person),
                        backgroundColor: Colors.white,
                        radius: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "user".tr(),
                      style: TextStyle(
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[
                                Color(0xff1877DE),
                                Color(0xff3B0BFE)
                              ],
                            ).createShader(
                                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        initialValue: '${bloc.state.profile?.email}',
                        style: Style.defaultText,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: "${"email".tr()}:",
                            filled: true,
                            suffixStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            prefixStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      child: BlocBuilder<ProfileCubit,ProfileState>(

                        builder: (context, snapshot) {
                          if(snapshot.profile!=null)
                          return TextFormField(
                            initialValue: '${bloc.state.profile.username}',
                            textInputAction: TextInputAction.done,
                            readOnly: true,
                            style: Style.defaultText,
                            decoration: InputDecoration(
                                labelText: "phone_number".tr(),
                                filled: true,
                                suffixStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                prefixStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          );
                          else return Container();
                        }
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (c) => Map()));
                      },
                      title: Text(
                        'show_shops'.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
