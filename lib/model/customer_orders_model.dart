
import 'dart:convert';

import 'package:online_shop/model/create_customer_order.dart';

class CustomerOrderBase {
  CustomerOrderBase({
    this.statusCode,
    this.description,
    this.object,
  });

  int statusCode;
  String description;
  List<CustomerOrder> object;

  factory CustomerOrderBase.fromRawJson(String str) => CustomerOrderBase.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerOrderBase.fromJson(Map<String, dynamic> json) => CustomerOrderBase(
    statusCode: json["statusCode"],
    description: json["description"],
    object: List<CustomerOrder>.from(json["object"].map((x) => CustomerOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "description": description,
    "object": List<dynamic>.from(object.map((x) => x.toJson())),
  };
}
