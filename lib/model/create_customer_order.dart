class CreateCustomerOrder {
  int cartGrandTotal;
  String createdDate;
  int id;
  int quantity;
  int totalPrice;

  CreateCustomerOrder(
      {this.cartGrandTotal,
        this.createdDate,
        this.id,
        this.quantity,
        this.totalPrice});

  CreateCustomerOrder.fromJson(Map<String, dynamic> json) {
    cartGrandTotal = json['cartGrandTotal'];
    createdDate = json['createdDate'];
    id = json['id'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartGrandTotal'] = this.cartGrandTotal;
    data['createdDate'] = this.createdDate;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}