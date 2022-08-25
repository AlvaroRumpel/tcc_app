import 'dart:convert';

class TrainingModel {
  String name;
  String training;
  int weight;
  int series;
  int repetitions;
  bool conclude;

  TrainingModel({
    this.name = 'Novo Treino',
    this.training = 'Novo Treino',
    this.weight = 0,
    this.series = 0,
    this.repetitions = 0,
    this.conclude = false,
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
