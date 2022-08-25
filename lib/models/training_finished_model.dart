import 'dart:convert';

import 'package:tcc_app/models/training_model.dart';

class TrainingFinishedModel {
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

  factory TrainingFinishedModel.fromMap(Map<String, dynamic> map) {
    return TrainingFinishedModel(
      training: List<TrainingModel>.from(
          map['training']?.map((x) => TrainingModel.fromMap(x))),
      xpEarned: map['xpEarned']?.toInt() ?? 0,
      time: map['time'] ?? '',
      clientId: map['client_id'] ?? '',
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingFinishedModel.fromJson(String source) =>
      TrainingFinishedModel.fromMap(json.decode(source));
}
