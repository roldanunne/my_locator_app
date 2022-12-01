// To parse this JSON data, do
//
//     final campusDataModel = campusDataModelFromJson(jsonString);

import 'dart:convert';

CampusDataModel campusDataModelFromJson(String str) => CampusDataModel.fromJson(json.decode(str));

String campusDataModelToJson(CampusDataModel data) => json.encode(data.toJson());

class CampusDataModel {
    CampusDataModel({
        required this.id,
        required this.name,
        required this.address,
        required this.logo,
        required this.about1,
        required this.about2,
        required this.about3,
        required this.agreement,
        required this.lat,
        required this.lng,
        required this.zoom,
        required this.bearing,
        required this.createdDt,
        required this.updatedDt,
        required this.campusLatLng,
    });

    int id;
    String name;
    String address;
    String logo;
    String about1;
    String about2;
    String about3;
    String agreement;
    double lat;
    double lng;
    double zoom;
    double bearing;
    DateTime createdDt;
    DateTime updatedDt;
    List<CampusLatlng> campusLatLng;

    factory CampusDataModel.fromJson(Map<String, dynamic> json) => CampusDataModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        logo: json["logo"],
        about1: json["about1"],
        about2: json["about2"],
        about3: json["about3"],
        agreement: json["agreement"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        zoom: json["zoom"].toDouble(),
        bearing: json["bearing"].toDouble(),
        createdDt: DateTime.parse(json["created_dt"]),
        updatedDt: DateTime.parse(json["updated_dt"]),
        campusLatLng: List<CampusLatlng>.from(json["campus_latlng"].map((x) => CampusLatlng.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "logo": logo,
        "about1": about1,
        "about2": about2,
        "about3": about3,
        "agreement": agreement,
        "lat": lat,
        "lng": lng,
        "zoom": zoom,
        "bearing": bearing,
        "created_dt": createdDt.toIso8601String(),
        "updated_dt": updatedDt.toIso8601String(),
        "campus_latlng": List<dynamic>.from(campusLatLng.map((x) => x.toJson())),
    };
}

class CampusLatlng {
    CampusLatlng({
        required this.id,
        required this.campusId,
        required this.lat,
        required this.lng,
        required this.type,
        required this.createdDt,
        required this.updatedDt,
    });

    int id;
    int campusId;
    double lat;
    double lng;
    int type;
    DateTime createdDt;
    DateTime updatedDt;

    factory CampusLatlng.fromJson(Map<String, dynamic> json) => CampusLatlng(
        id: json["id"],
        campusId: json["campus_id"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        type: json["type"],
        createdDt: DateTime.parse(json["created_dt"]),
        updatedDt: DateTime.parse(json["updated_dt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "campus_id": campusId,
        "lat": lat,
        "lng": lng,
        "type": type,
        "created_dt": createdDt.toIso8601String(),
        "updated_dt": updatedDt.toIso8601String(),
    };
}
