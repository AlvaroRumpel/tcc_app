import 'dart:convert';

import 'package:tcc_app/models/training_model.dart';

class TrainingFinishedModel {
  List<TrainingModel> training;
  int xpEarned;
  String time;
  TrainingFinishedModel({
    required this.training,
    required this.xpEarned,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'training': training.map((x) => x.toMap()).toList(),
      'xpEarned': xpEarned,
      'time': time,
    };
  }

  factory TrainingFinishedModel.fromMap(Map<String, dynamic> map) {
    return TrainingFinishedModel(
      training: List<TrainingModel>.from(
          map['training']?.map((x) => TrainingModel.fromMap(x))),
      xpEarned: map['xpEarned']?.toInt() ?? 0,
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingFinishedModel.fromJson(String source) =>
      TrainingFinishedModel.fromMap(json.decode(source));
}
