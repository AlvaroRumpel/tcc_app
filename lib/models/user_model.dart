import 'dart:convert';

class ClientModel {
  String? id;
  String clientId;
  int bodyFat;
  String goal;
  int height;
  int weight;
  int level;
  int xp;
  int sex;
  String birthDate;

  ClientModel({
    this.id,
    required this.clientId,
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
      'client_id': clientId,
      'body_fat': bodyFat,
      'goal': goal,
      'height': height,
      'weight': weight,
      'level': level,
      'xp': xp,
      'sex': sex,
      'birth_date': birthDate,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? '',
      clientId: map['client_id'] ?? '',
      bodyFat: int.parse(map['body_fat']),
      goal: map['goal'] ?? '',
      height: int.parse(map['height']),
      weight: int.parse(map['weight']),
      level: map['level']?.toInt() ?? 0,
      xp: map['xp']?.toInt() ?? 0,
      sex: map['sex']?.toInt() ?? 0,
      birthDate: map['birth_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source));
}
