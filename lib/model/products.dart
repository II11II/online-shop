class Products {
  int statusCode;
  String description;
  List<Product> object;

  Products({this.statusCode, this.description, this.object});

  Products.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    description = json['description'];
    if (json['object'] != null) {
      object = new List<Product>();
      json['object'].forEach((v) {
        object.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['description'] = this.description;
    if (this.object != null) {
      data['object'] = this.object.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int id;
  String name;
  String brand;
  String model;
  String description;
  String mainImage;
  String status;
  bool isFavourite;
  int price;
  int oldPrice;
  int rate;
  String measurement;
  bool hashDiscount;
  int quantity;
  List cartItems;

  Product(
      {this.id,
        this.isFavourite,
        this.name,
        this.brand,
        this.model,
        this.description,
        this.mainImage,
        this.status,
        this.price,
        this.oldPrice,
        this.rate,
        this.measurement,
        this.hashDiscount,
        this.quantity,
        this.cartItems});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isFavourite=json['favorite'];
    name = json['name'];
    brand = json['brand'];
    model = json['model'];
    description = json['description'];
    mainImage = json['mainImage'];
    status = json['status'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    rate = json['rate'];
    measurement = json['measurement'];
    hashDiscount = json['hashDiscount'];
    quantity = json['quantity'];
    if (json['cartItems'] != null) {
      cartItems = new List();
      json['cartItems'].forEach((v) {
        // cartItems.add(new card.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['favorite'] = this.isFavourite;
    data['model'] = this.model;
    data['description'] = this.description;
    data['mainImage'] = this.mainImage;
    data['status'] = this.status;
    data['price'] = this.price;
    data['oldPrice'] = this.oldPrice;
    data['rate'] = this.rate;
    data['measurement'] = this.measurement;
    data['hashDiscount'] = this.hashDiscount;
    data['quantity'] = this.quantity;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}