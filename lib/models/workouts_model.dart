import 'dart:convert';

import 'package:play_workout/models/training_model.dart';

class WorkoutsModel {
  List<TrainingModel> trainings;
  String? id;
  String clientId;
  String trainerId;
  bool deleted;
  bool saved;

  WorkoutsModel({
    required this.trainings,
    this.id,
    required this.clientId,
    required this.trainerId,
    this.deleted = false,
    this.saved = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'trainings': trainings.map((x) => x.toMap()).toList(),
      'client_id': clientId,
      'trainer_id': trainerId,
      'deleted': deleted,
    };
  }

  factory WorkoutsModel.fromMap(
      Map<String, dynamic> map, String id, bool saved) {
    return WorkoutsModel(
      trainings: List<TrainingModel>.from(
          map['trainings']?.map((x) => TrainingModel.fromMap(x))),
      id: id,
      clientId: map['client_id'] ?? '',
      trainerId: map['trainer_id'] ?? '',
      deleted: map['deleted'] ?? false,
      saved: saved,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutsModel.fromJson(String source, String id, bool saved) =>
      WorkoutsModel.fromMap(json.decode(source), id, saved);
}
