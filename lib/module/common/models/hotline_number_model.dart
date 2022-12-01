// To parse this JSON data, do
//
//     final hotlineNumberModel = hotlineNumberModelFromJson(jsonString);

import 'dart:convert';

List<HotlineNumberModel> hotlineNumberModelFromJson(String str) => List<HotlineNumberModel>.from(json.decode(str).map((x) => HotlineNumberModel.fromJson(x)));

String hotlineNumberModelToJson(List<HotlineNumberModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotlineNumberModel {
    HotlineNumberModel({
        required this.id,
        required this.title,
        required this.contact,
        required this.description,
        required this.status,
        required this.createdDt,
        required this.updatedDt,
    });

    int id;
    String title;
    String contact;
    String description;
    int status;
    DateTime createdDt;
    DateTime updatedDt;

    factory HotlineNumberModel.fromJson(Map<String, dynamic> json) => HotlineNumberModel(
        id: json["id"],
        title: json["title"],
        contact: json["contact"],
        description: json["description"],
        status: json["status"],
        createdDt: DateTime.parse(json["created_dt"]),
        updatedDt: DateTime.parse(json["updated_dt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "contact": contact,
        "description": description,
        "status": status,
        "created_dt": createdDt.toIso8601String(),
        "updated_dt": updatedDt.toIso8601String(),
    };
}
