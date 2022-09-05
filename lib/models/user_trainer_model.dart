import 'dart:convert';

class UserTrainerModel {
  String id;
  String clientId;
  String name;
  int bodyFat;
  String goal;
  int height;
  int weight;
  int level;
  int xp;
  int sex;
  String birthDate;
  bool active;
  bool accepted;
  bool hasResponse;
  String? fcmToken;

  UserTrainerModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.bodyFat,
    required this.goal,
    required this.height,
    required this.weight,
    required this.level,
    required this.xp,
    required this.sex,
    required this.birthDate,
    required this.active,
    required this.accepted,
    required this.hasResponse,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'name': name,
      'bodyFat': bodyFat,
      'goal': goal,
      'height': height,
      'weight': weight,
      'level': level,
      'xp': xp,
      'sex': sex,
      'birthDate': birthDate,
      'active': active,
      'accepted': accepted,
      'hasResponse': hasResponse,
      'fcm_token': fcmToken,
    };
  }

  factory UserTrainerModel.fromMap(Map<String, dynamic> map) {
    return UserTrainerModel(
      id: map['id'] ?? '',
      clientId: map['clientId'] ?? '',
      name: map['name'] ?? '',
      bodyFat: map['bodyFat']?.toInt() ?? 0,
      goal: map['goal'] ?? '',
      height: map['height']?.toInt() ?? 0,
      weight: map['weight']?.toInt() ?? 0,
      level: map['level']?.toInt() ?? 0,
      xp: map['xp']?.toInt() ?? 0,
      sex: map['sex']?.toInt() ?? 0,
      birthDate: map['birthDate'] ?? '',
      active: map['active'] ?? false,
      accepted: map['accepted'] ?? false,
      hasResponse: map['hasResponse'] ?? false,
      fcmToken: map['fcmToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTrainerModel.fromJson(String source) =>
      UserTrainerModel.fromMap(json.decode(source));
}
