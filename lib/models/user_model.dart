import 'dart:convert';

import 'package:tcc_app/models/trainer_user_model.dart';

class UserModel {
  String? id;
  String? clientId;
  String? name;
  int bodyFat;
  String goal;
  int height;
  int weight;
  int level;
  int xp;
  int sex;
  String birthDate;
  List<TrainerUserModel> trainers;

  UserModel({
    this.id,
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
    required this.trainers,
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
      'name': name,
      'trainers': trainers.map((e) => e.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String? id) {
    List<TrainerUserModel> trainers = [];
    map['trainers']
        .forEach((item) => trainers.add(TrainerUserModel.fromMap(item)));
    return UserModel(
      id: map['id'] ?? id,
      clientId: map['client_id'] ?? '',
      bodyFat: map['body_fat'],
      goal: map['goal'] ?? '',
      height: map['height'],
      weight: map['weight'],
      level: map['level']?.toInt() ?? 0,
      xp: map['xp']?.toInt() ?? 0,
      sex: map['sex']?.toInt() ?? 0,
      birthDate: map['birth_date'] ?? '',
      name: map['name'] ?? '',
      trainers: trainers,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source, String? id) =>
      UserModel.fromMap(json.decode(source), id);
}
