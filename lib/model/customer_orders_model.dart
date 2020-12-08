
import 'dart:convert';

import 'package:online_shop/model/products.dart';

class CustomerOrder {
  CustomerOrder({
    this.statusCode,
    this.description,
    this.object,
  });

  int statusCode;
  String description;
  List<Object> object;

  factory CustomerOrder.fromRawJson(String str) => CustomerOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerOrder.fromJson(Map<String, dynamic> json) => CustomerOrder(
    statusCode: json["statusCode"],
    description: json["description"],
    object: List<Object>.from(json["object"].map((x) => Object.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "description": description,
    "object": List<dynamic>.from(object.map((x) => x.toJson())),
  };
}

class Object {
  Object({
    this.id,
    this.product,
    this.createdDate,
    this.statusForOrder,
    this.quantity,
    this.totalPrice,
    this.cartGrandTotal,
  });

  int id;
  Product product;
  DateTime createdDate;
  String statusForOrder;
  int quantity;
  num totalPrice;
  double cartGrandTotal;

  factory Object.fromRawJson(String str) => Object.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Object.fromJson(Map<String, dynamic> json) => Object(
    id: json["id"],
    product: Product.fromJson(json["product"]),
    createdDate: DateTime.parse(json["createdDate"]),
    statusForOrder: json["statusForOrder"],
    quantity: json["quantity"],
    totalPrice: json["totalPrice"],
    cartGrandTotal: json["cartGrandTotal"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
    "createdDate": createdDate.toIso8601String(),
    "statusForOrder": statusForOrder,
    "quantity": quantity,
    "totalPrice": totalPrice,
    "cartGrandTotal": cartGrandTotal,
  };
}


class Categories {
  Categories({
    this.id,
    this.name,
    this.imageCategory,
    this.typeCategory,
    this.clicked,
    this.description,
  });

  int id;
  String name;
  String imageCategory;
  int typeCategory;
  bool clicked;
  String description;

  factory Categories.fromRawJson(String str) => Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    name: json["name"],
    imageCategory: json["imageCategory"],
    typeCategory: json["typeCategory"],
    clicked: json["clicked"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageCategory": imageCategory,
    "typeCategory": typeCategory,
    "clicked": clicked,
    "description": description,
  };
}