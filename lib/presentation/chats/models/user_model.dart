class UserModel {
  String? name;
  String? email;
  String? id;

  UserModel({this.name, this.email, this.id});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['Name'], email: json['email'], id: json['id']);
  }
}
