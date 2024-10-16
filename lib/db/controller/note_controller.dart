import 'package:db_bloc/db/db_controller.dart';
import 'package:db_bloc/db/db_operation_.dart';
import 'package:db_bloc/model/note_model.dart';
import 'package:db_bloc/storge/pref_controller.dart';
import 'package:sqflite/sqflite.dart';

class NoteController extends DbOperation<Note> {
  Database database = DbController().database;

  @override
  Future<int> create(Note model) async {
    // TODO: implement create
    int newRow = await database.insert('notes', model.toMap());
    return newRow;
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    int deletedRow =
        await database.delete('notes', where: 'id = ?', whereArgs: [id]);
    return deletedRow == 1;
  }

  @override
  Future<List<Note>> read() async {
    // TODO: implement read
    List<Map<String, dynamic>> rows = await database.query('notes',
        where: 'user_id = ?',
        whereArgs: [
          SharedPrefController().getValueKey<int>(key: PrefKey.id.toString())
        ]);
    return rows.map((e) => Note.fromMap(e)).toList();
  }

  @override
  Future<bool> update(Note model) async {
    int updatedRow = await database
        .update('notes', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
    return updatedRow == 1;
  }
}
