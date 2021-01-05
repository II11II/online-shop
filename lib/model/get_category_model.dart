class GetCategory {
  int statusCode;
  String description;
  List<Categories> object;

  GetCategory({this.statusCode, this.description, this.object});

  GetCategory.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    description = json['description'];
    if (json['object'] != null) {
      object = new List<Categories>();
      json['object'].forEach((v) {
        object.add(new Categories.fromJson(v));
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


class Categories {
  bool clicked;
  String description;
  int id;
  String imageCategory;
  String name;
  int typeCategory;

  Categories(
      {this.clicked,
        this.description,
        this.id,
        this.imageCategory,
        this.name,
        this.typeCategory});

  Categories.fromJson(Map<String, dynamic> json) {
    clicked = json['clicked'];
    description = json['description'];
    id = json['id'];
    imageCategory = json['imageCategory'];
    name = json['name'];
    typeCategory = json['typeCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clicked'] = this.clicked;
    data['description'] = this.description;
    data['id'] = this.id;
    data['imageCategory'] = this.imageCategory;
    data['name'] = this.name;
    data['typeCategory'] = this.typeCategory;
    return data;
  }
}