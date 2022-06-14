import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String emailKey = 'email';
String passwordKey = 'password';
String userNameKey = 'userName';
String clientKey = 'clients';

class LocalStorage {
  static Future<String> getEmail() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(emailKey) ?? '';
  }

  static Future<String> getPassword() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(passwordKey) ?? '';
  }

  static Future<String> getUserName() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(userNameKey) ?? '';
  }

  static Future<bool> getIsClients() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(clientKey) ?? false;
  }

  static Future<void> setEmail(String email) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(emailKey, email);
  }

  static Future<void> setPassword(String password) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(passwordKey, GetUtils.removeAllWhitespace(password));
  }

  static Future<void> setUserName(String userName) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(userNameKey, userName);
  }

  static Future<void> setIsClients(bool isClient) async {
    var storage = await SharedPreferences.getInstance();
    storage.setBool(clientKey, isClient);
  }
}
