class UserModel {
  final String id;
  final String name;
  final String email;
  final String? image;

  UserModel(this.id, this.name, this.email, {this.image});

  // fromjson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['_id'], json['name'], json['email']);
  }

  // tojson
  Map<String, dynamic> toJson() => {'name': name, 'image': image};

  // empty
  factory UserModel.empty() => UserModel('', '', '');
}
