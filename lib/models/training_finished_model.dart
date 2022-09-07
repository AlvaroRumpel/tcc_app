import 'dart:convert';

import 'package:play_workout/models/training_model.dart';

class TrainingFinishedModel {
  String? id;
  String clientId;
  List<TrainingModel> training;
  int xpEarned;
  String time;
  DateTime date;
  TrainingFinishedModel({
    required this.clientId,
    required this.training,
    required this.xpEarned,
    required this.time,
    required this.date,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'training': training.map((x) => x.toMap()).toList(),
      'xpEarned': xpEarned,
      'time': time,
      'client_id': clientId,
      'date': date,
    };
  }

  factory TrainingFinishedModel.fromMap(Map<String, dynamic> map, String id) {
    return TrainingFinishedModel(
      id: map['id'] ?? id,
      training: List<TrainingModel>.from(
          map['training']?.map((x) => TrainingModel.fromMap(x))),
      xpEarned: map['xpEarned']?.toInt() ?? 0,
      time: map['time'] ?? '',
      clientId: map['client_id'] ?? '',
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['date'].millisecondsSinceEpoch)
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingFinishedModel.fromJson(String source, String id) =>
      TrainingFinishedModel.fromMap(json.decode(source), id);
}
