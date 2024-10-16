import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

enum PrefKey { loggedIn, name, email, id }

class SharedPrefController {
  SharedPrefController._();

  static final SharedPrefController _instance = SharedPrefController._();

  factory SharedPrefController() {
    return _instance;
  }

  late SharedPreferences _sharedPreferences;

  SharedPreferences get sharedPreferences => _sharedPreferences;

  Future<void> initPref() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKey.loggedIn.toString()) ?? false;

  Future<bool> clear() async => await _sharedPreferences.clear();

  T? getValueKey<T>({required String key}) {
    return _sharedPreferences.get(key) as T;
  }

  Future<void> save({required User user}) async {
    await _sharedPreferences.setBool(PrefKey.loggedIn.toString(), true);
    await _sharedPreferences.setString(PrefKey.name.toString(), user.name);
    await _sharedPreferences.setInt(PrefKey.id.toString(), user.id);
    await _sharedPreferences.setString(PrefKey.email.toString(), user.email);
  }
}
