import 'dart:convert';

// To parse this JSON data, do
// final hasBookingModel = monthlyBookingFromJson(jsonString);
List<Map<String, bool>> monthlyBookingFromJson(String str) => List<Map<String, bool>>.from(json.decode(str).map((x) => Map.from(x).map((k, v) => MapEntry<String, bool>(k, v))));
String monthlyBookingToJson(List<Map<String, bool>> data) => json.encode(List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))));


// To parse this JSON data, do
// final monthlyCampaignModel = monthlyCampaignFromJson(jsonString);
Map<String, bool> monthlyCampaignFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, bool>(k, v));
String monthlyCampaignToJson(Map<String, bool> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
