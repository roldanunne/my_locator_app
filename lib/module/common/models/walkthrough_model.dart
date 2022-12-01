// To parse required this JSON data, do
//
//     final walkthroughModel = walkthroughModelFromJson(jsonString);

import 'dart:convert';

List<WalkthroughModel> walkthroughModelFromJson(String str) => List<WalkthroughModel>.from(json.decode(str).map((x) => WalkthroughModel.fromJson(x)));

String walkthroughModelToJson(List<WalkthroughModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalkthroughModel {
    WalkthroughModel({
        required this.id,
        required this.title,
        required this.desc,
        required this.updatedDt,
    });

    int id;
    String title;
    String desc;
    DateTime updatedDt;

    factory WalkthroughModel.fromJson(Map<String, dynamic> json) => WalkthroughModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        updatedDt: DateTime.parse(json["updated_dt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "updated_dt": updatedDt.toIso8601String(),
    };
}
