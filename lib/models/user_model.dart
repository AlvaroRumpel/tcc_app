import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  String id;
  String client_id;
  int body_fat;
  String goal;
  int height;
  int weight;
  int level;
  int xp;
  int sex;
  String birth_date;
  UserModel({
    required this.id,
    required this.client_id,
    required this.body_fat,
    required this.goal,
    required this.height,
    required this.weight,
    required this.level,
    required this.xp,
    required this.sex,
    required this.birth_date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': client_id,
      'body_fat': body_fat,
      'goal': goal,
      'height': height,
      'weight': weight,
      'level': level,
      'xp': xp,
      'sex': sex,
      'birth_date': birth_date,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      client_id: map['client_id'] ?? '',
      body_fat: int.parse(map['body_fat']),
      goal: map['goal'] ?? '',
      height: int.parse(map['height']),
      weight: int.parse(map['weight']),
      level: map['level']?.toInt() ?? 0,
      xp: map['xp']?.toInt() ?? 0,
      sex: map['sex']?.toInt() ?? 0,
      birth_date: map['birth_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
