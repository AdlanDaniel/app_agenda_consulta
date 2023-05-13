import 'dart:convert';

class PatientModel {
  String? name;
  String? doctor;
  String? id;
  String? date;
  bool? present;
  bool? finalized;
  PatientModel({
    this.name,
    this.doctor,
    this.id,
    this.date,
    this.present = false,
    this.finalized = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'doctor': doctor,
      'id': id,
      'date': date,
      'present': present,
      'finalized': finalized,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      name: map['name'] != null ? map['name'] as String : null,
      doctor: map['doctor'] != null ? map['doctor'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      present: map['present'] != null ? map['present'] as bool : null,
      finalized: map['finalized'] != null ? map['finalized'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
