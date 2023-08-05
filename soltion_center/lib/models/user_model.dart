import 'category_model.dart';

class UserModel {
  String? userId;
  String? username;
  String? email;
  String? password;
  bool? admin;
  //categories ID will be stored here
  List<String>? categories;

  UserModel({
    this.userId,
    this.username,
    required this.email,
    required this.password,
    this.admin = false,
    this.categories,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    username = json['username'];
    admin = json['admin'];
    categories = json['categories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['username'] = username;
    data['admin'] = admin ?? false;
    data['categories'] = categories ?? [];
    return data;
  }
}