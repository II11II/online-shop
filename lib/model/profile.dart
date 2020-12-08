import 'dart:convert';

class Profile {
  Profile({
    this.username,
    this.password,
    this.role,
    this.enable,
    this.token,
    this.id,
    this.image,
    this.bio,
    this.email,
    this.date,
    this.registered,
  });

  String username;
  String password;
  String role;
  bool enable;
  String token;
  int id;
  dynamic image;
  dynamic bio;
  String email;
  dynamic date;
  bool registered;

  Profile copyWith({
    String username,
    String password,
    String role,
    bool enable,
    String token,
    int id,
    dynamic image,
    dynamic bio,
    String email,
    dynamic date,
    bool registered,
  }) =>
      Profile(
        username: username ?? this.username,
        password: password ?? this.password,
        role: role ?? this.role,
        enable: enable ?? this.enable,
        token: token ?? this.token,
        id: id ?? this.id,
        image: image ?? this.image,
        bio: bio ?? this.bio,
        email: email ?? this.email,
        date: date ?? this.date,
        registered: registered ?? this.registered,
      );

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    username: json["username"],
    password: json["password"],
    role: json["role"],
    enable: json["enable"],
    token: json["token"],
    id: json["id"],
    image: json["image"],
    bio: json["bio"],
    email: json["email"],
    date: json["date"],
    registered: json["registered"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "role": role,
    "enable": enable,
    "token": token,
    "id": id,
    "image": image,
    "bio": bio,
    "email": email,
    "date": date,
    "registered": registered,
  };
}