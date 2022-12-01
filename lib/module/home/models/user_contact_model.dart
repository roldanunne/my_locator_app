// To parse required this JSON data, do
//
//     final userContactModel = userContactModelFromJson(jsonString);

import 'dart:convert';

List<UserContactModel> userContactModelFromJson(String str) => List<UserContactModel>.from(json.decode(str).map((x) => UserContactModel.fromJson(x)));

String userContactModelToJson(List<UserContactModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserContactModel {
    UserContactModel({
        required this.id,
        required this.userId,
        required this.name,
        required this.contact,
        required this.status,
        required this.createdDt,
        required this.updatedDt,
    });

    int id;
    int userId;
    String name;
    String contact;
    int status;
    DateTime createdDt;
    DateTime updatedDt;

    factory UserContactModel.fromJson(Map<String, dynamic> json) => UserContactModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        contact: json["contact"],
        status: json["status"],
        createdDt: DateTime.parse(json["created_dt"]),
        updatedDt: DateTime.parse(json["updated_dt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "contact": contact,
        "status": status,
        "created_dt": createdDt.toIso8601String(),
        "updated_dt": updatedDt.toIso8601String(),
    };
}
