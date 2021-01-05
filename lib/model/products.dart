import 'get_category_model.dart';

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
  String brand;
  Categories categories;
  String description;
  bool favorite;
  bool hashDiscount;
  int id;
  String mainImage;
  String measurement;
  String model;
  String name;
  int oldPrice;
  int price;
  int quantity;
  int rate;
  String status;

  Product(
      {this.brand,
        this.categories,
        this.description,
        this.favorite,
        this.hashDiscount,
        this.id,
        this.mainImage,
        this.measurement,
        this.model,
        this.name,
        this.oldPrice,
        this.price,
        this.quantity,
        this.rate,
        this.status});

  Product.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
    description = json['description'];
    favorite = json['favorite'];
    hashDiscount = json['hashDiscount'];
    id = json['id'];
    mainImage = json['mainImage'];
    measurement = json['measurement'];
    model = json['model'];
    name = json['name'];
    oldPrice = json['oldPrice'];
    price = json['price'];
    quantity = json['quantity'];
    rate = json['rate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    if (this.categories != null) {
      data['categories'] = this.categories.toJson();
    }
    data['description'] = this.description;
    data['favorite'] = this.favorite;
    data['hashDiscount'] = this.hashDiscount;
    data['id'] = this.id;
    data['mainImage'] = this.mainImage;
    data['measurement'] = this.measurement;
    data['model'] = this.model;
    data['name'] = this.name;
    data['oldPrice'] = this.oldPrice;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['rate'] = this.rate;
    data['status'] = this.status;
    return data;
  }
}

//
// class Product {
//   int id;
//   String name;
//   String brand;
//   String model;
//   String description;
//   String mainImage;
//   String status;
//   bool isFavourite;
//   int price;
//   int oldPrice;
//   int rate;
//   String measurement;
//   bool hashDiscount;
//   int quantity;
//   List cartItems;
//
//   Product(
//       {this.id,
//         this.isFavourite,
//         this.name,
//         this.brand,
//         this.model,
//         this.description,
//         this.mainImage,
//         this.status,
//         this.price,
//         this.oldPrice,
//         this.rate,
//         this.measurement,
//         this.hashDiscount,
//         this.quantity,
//         this.cartItems});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isFavourite=json['favorite'];
//     name = json['name'];
//     brand = json['brand'];
//     model = json['model'];
//     description = json['description'];
//     mainImage = json['mainImage'];
//     status = json['status'];
//     price = json['price'];
//     oldPrice = json['oldPrice'];
//     rate = json['rate'];
//     measurement = json['measurement'];
//     hashDiscount = json['hashDiscount'];
//     quantity = json['quantity'];
//     if (json['cartItems'] != null) {
//       cartItems = new List();
//       json['cartItems'].forEach((v) {
//         // cartItems.add(new card.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['brand'] = this.brand;
//     data['favorite'] = this.isFavourite;
//     data['model'] = this.model;
//     data['description'] = this.description;
//     data['mainImage'] = this.mainImage;
//     data['status'] = this.status;
//     data['price'] = this.price;
//     data['oldPrice'] = this.oldPrice;
//     data['rate'] = this.rate;
//     data['measurement'] = this.measurement;
//     data['hashDiscount'] = this.hashDiscount;
//     data['quantity'] = this.quantity;
//     if (this.cartItems != null) {
//       data['cartItems'] = this.cartItems.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }