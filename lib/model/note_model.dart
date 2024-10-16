class Note {
  late int id;
  late int userId;
  late String title;
  late String details;

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['user_id'];
    title = map['title'];
    details = map['details'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['user_id'] = userId;
    map['title'] = title;
    map['details'] = details;
    return map;
  }
}
