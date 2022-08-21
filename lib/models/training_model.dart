import 'dart:convert';

class TrainingModel {
  String name;
  String training;
  int weight;
  int series;
  int repetitions;

  TrainingModel({
    required this.name,
    required this.training,
    required this.weight,
    required this.series,
    required this.repetitions,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'training': training,
      'weight': weight,
      'series': series,
      'repetitions': repetitions,
    };
  }

  factory TrainingModel.fromMap(Map<String, dynamic> map) {
    return TrainingModel(
      name: map['name'] ?? '',
      training: map['training'] ?? '',
      weight: map['weight']?.toInt() ?? 0,
      series: map['series']?.toInt() ?? 0,
      repetitions: map['repetitions']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingModel.fromJson(String source) =>
      TrainingModel.fromMap(json.decode(source));
}
