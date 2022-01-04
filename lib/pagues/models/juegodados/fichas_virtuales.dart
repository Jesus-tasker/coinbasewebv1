// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Fichas_virtuales welcomeFromJson(String str) =>
    Fichas_virtuales.fromJson(json.decode(str));

String welcomeToJson(Fichas_virtuales data) => json.encode(data.toJson());

class Fichas_virtuales {
  Fichas_virtuales({
    required this.timestampSting,
    required this.timestampint,
    required this.fichas,
  });

  String timestampSting;
  int timestampint;
  double fichas;

  factory Fichas_virtuales.fromJson(Map<String, dynamic> json) =>
      Fichas_virtuales(
        timestampSting: json["timestamp_sting"],
        timestampint: json["timestampint"],
        fichas: json["fichas"].toDouble(),
      );
  factory Fichas_virtuales.fromdocument(DocumentSnapshot json) =>
      Fichas_virtuales(
        timestampSting: json["timestamp_sting"],
        timestampint: json["timestampint"],
        fichas: json["fichas"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "timestamp_sting": timestampSting,
        "timestampint": timestampint,
        "fichas": fichas,
      };
}
