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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTrainerModel.fromJson(String source) =>
      UserTrainerModel.fromMap(json.decode(source));
}
