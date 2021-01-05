import 'package:online_shop/model/products.dart';

class CustomerOrder {
  num cartGrandTotal;
  String createdDate;
  int id;
  Product product;
  int quantity;
  String statusForOrder;
  num totalPrice;

  CustomerOrder(
      {this.cartGrandTotal,
        this.createdDate,
        this.id,
        this.product,
        this.quantity,
        this.statusForOrder,
        this.totalPrice});

  CustomerOrder.fromJson(Map<String, dynamic> json) {
    cartGrandTotal = json['cartGrandTotal'];
    createdDate = json['createdDate'];
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    statusForOrder = json['statusForOrder'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartGrandTotal'] = this.cartGrandTotal;
    data['createdDate'] = this.createdDate;
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['quantity'] = this.quantity;
    data['statusForOrder'] = this.statusForOrder;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
