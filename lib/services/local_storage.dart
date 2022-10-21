import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/models/user_model.dart';

String emailKey = 'email';
String passwordKey = 'password';
String userNameKey = 'userName';
String clientKey = 'clients';
String clientModel = 'clientModel';
String trainerModel = 'trainerModel';
String firebaseToken = 'firebaseToken';
String termsAccepted = 'termsAccepted';

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

  static Future<UserModel?> getClient() async {
    var storage = await SharedPreferences.getInstance();
    String? client = storage.getString(clientModel);
    if (client == null) return null;
    return UserModel.fromJson(client, null);
  }

  static Future<TrainerModel?> getTrainer() async {
    var storage = await SharedPreferences.getInstance();
    String? trainer = storage.getString(trainerModel);
    if (trainer == null) return null;
    return TrainerModel.fromJson(trainer, null);
  }

  static Future<String?> getFirebaseToken() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(firebaseToken);
  }

  static Future<bool?> getTermsAccepted() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(termsAccepted);
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

  static Future<void> setClient(UserModel client) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(clientModel, client.toJson());
  }

  static Future<void> setTrainer(TrainerModel trainer) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(trainerModel, trainer.toJson());
  }

  static Future<void> setFirebaseToken(String token) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(firebaseToken, token);
  }

  static Future<bool?> setTermsAccepted(bool accepted) async {
    var storage = await SharedPreferences.getInstance();
    return storage.setBool(termsAccepted, accepted);
  }

  static Future<void> clearAllData() async {
    var storage = await SharedPreferences.getInstance();
    await storage.clear();
  }
}
