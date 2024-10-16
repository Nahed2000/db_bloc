abstract class DbOperation<Model> {
  /*
  Create a new database operation => Note
   */
  Future<int> create(Model model);

  Future<bool> delete(int id);

  Future<bool> update(Model model);

  Future<List<Model>> read();
}
