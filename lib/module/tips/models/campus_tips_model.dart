// To parse required this JSON data, do
//
//     final campusTipsModel = campusTipsModelFromJson(jsonString);

import 'dart:convert';

List<CampusTipsModel> campusTipsModelFromJson(String str) => List<CampusTipsModel>.from(json.decode(str).map((x) => CampusTipsModel.fromJson(x)));

String campusTipsModelToJson(List<CampusTipsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CampusTipsModel {
    CampusTipsModel({
        required this.id,
        required this.title,
        required this.procedure1,
        required this.procedure2,
        required this.procedure3,
        required this.createdDt,
        required this.updatedDt,
    });

    int id;
    String title;
    String procedure1;
    String procedure2;
    String procedure3;
    DateTime createdDt;
    DateTime updatedDt;

    factory CampusTipsModel.fromJson(Map<String, dynamic> json) => CampusTipsModel(
        id: json["id"],
        title: json["title"],
        procedure1: json["procedure1"],
        procedure2: json["procedure2"] ?? '',
        procedure3: json["procedure3"] ?? '',
        createdDt: DateTime.parse(json["created_dt"]),
        updatedDt: DateTime.parse(json["updated_dt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "procedure1": procedure1,
        "procedure2": procedure2,
        "procedure3": procedure3,
        "created_dt": createdDt.toIso8601String(),
        "updated_dt": updatedDt.toIso8601String(),
    };
}
