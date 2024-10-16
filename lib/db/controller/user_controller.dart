import 'package:db_bloc/db/db_controller.dart';
import 'package:db_bloc/db/db_operation_.dart';
import 'package:db_bloc/model/user.dart';
import 'package:db_bloc/storge/pref_controller.dart';
import 'package:sqflite/sqflite.dart';

class UserController extends DbOperation<User> {
  Database database = DbController().database;

  Future<bool> login({required String email, required String password}) async {
    List<Map<String, dynamic>> users = await database.query('users',
        where: 'email = ? AND password =?', whereArgs: [email, password]);
    if (users.isNotEmpty) {
      User user = User.fromMap(users.first);
      await SharedPrefController().save(user: user);
    }
    return users.isNotEmpty;
  }

  Future<bool> logout() async => await SharedPrefController().clear();

  @override
  Future<int> create(User model) async {
    // TODO: implement create
    int newUserId = await database.insert('users', model.toMap());
    return newUserId;
  }

  @override
  Future<bool> delete(int id) async {
    int deletedUser =
        await database.delete('user', whereArgs: [id], where: 'id = ?');
    return deletedUser == 1;
  }

  @override
  Future<List<User>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(User model) async {
    // TODO: implement update
    int deletedUser = await database
        .update('users', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
    return deletedUser == 1;
  }
}
