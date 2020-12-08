import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.red,
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FeatherIcons.shoppingCart,size: 60,color: Colors.white,),
              Divider(thickness: 100,height: 110, color: Colors.blueAccent,),
              Text("azon".tr(), style: TextStyle(fontSize: 60),)
            ],
          ),
        ),
      ),
    );
  }
}
