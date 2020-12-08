class GetCategory {
  int statusCode;
  String description;
  List<Object> object;

  GetCategory({this.statusCode, this.description, this.object});

  GetCategory.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    description = json['description'];
    if (json['object'] != null) {
      object = new List<Object>();
      json['object'].forEach((v) {
        object.add(new Object.fromJson(v));
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

class Object {
  int id;
  String name;
  String imageCategory;
  int typeCategory;
  String iconCategory;
  bool clicked;
  String description;

  Object(
      {this.id,
        this.name,
        this.imageCategory,
        this.typeCategory,
        this.iconCategory,
        this.clicked,
        this.description});

  Object.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageCategory = json['imageCategory'];
    typeCategory = json['typeCategory'];
    iconCategory = json['iconCategory'];
    clicked = json['clicked'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageCategory'] = this.imageCategory;
    data['typeCategory'] = this.typeCategory;
    data['iconCategory'] = this.iconCategory;
    data['clicked'] = this.clicked;
    data['description'] = this.description;
    return data;
  }
}