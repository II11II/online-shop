import 'package:flutter/material.dart';
import 'package:online_shop/model/create_customer_order.dart';
import 'package:easy_localization/easy_localization.dart';

class StatusPage extends StatelessWidget {
  final CustomerOrder order;

  const StatusPage({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("status".tr()),
      ),
      body: Theme(
        data: ThemeData.dark(),
        child: Stepper(
          steps: [
            Step(
                content: FlutterLogo(
                  size: 10,
                ),
                title: Text("${order.statusForOrder}")),
            Step(
                content: FlutterLogo(
                  size: 10,
                ),
                title: Text("${order.statusForOrder}")),
            Step(
                content: FlutterLogo(
                  size: 10,
                ),
                title: Text("${order.statusForOrder}")),
            Step(
                content: FlutterLogo(
                  size: 10,
                ),
                title: Text("${order.statusForOrder}")),
            Step(
                content: FlutterLogo(
                  size: 10,
                ),
                title: Text("${order.statusForOrder}")),
          ],
        ),
      ),
    );
  }
}
