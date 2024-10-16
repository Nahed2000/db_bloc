class User {
  late int id;
  late String name;
  late String email;
  late String password;

  User();

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    password = map['password'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    map['email'] = email;
    return map;
  }
}
