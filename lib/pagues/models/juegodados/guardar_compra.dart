// To parse this JSON data, do
//
//     final guardarCompra = guardarCompraFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

GuardarCompra guardarCompraFromJson(String str) =>
    GuardarCompra.fromJson(json.decode(str));

String guardarCompraToJson(GuardarCompra data) => json.encode(data.toJson());

class GuardarCompra {
  GuardarCompra({
    required this.timestampSting,
    required this.timestampint,
    required this.uid,
    required this.fichas,
    required this.diamantes,
    required this.pagototal,
    required this.critopagada,
    required this.hash,
  });

  String timestampSting;
  int timestampint;
  String uid;
  double fichas;
  double diamantes;
  String pagototal;
  String critopagada;
  String hash;

  factory GuardarCompra.fromJson(Map<String, dynamic> json) => GuardarCompra(
        timestampSting: json["timestamp_sting"],
        timestampint: json["timestampint"],
        uid: json["uid"],
        fichas: json["fichas"].toDouble(),
        diamantes: json["diamantes"].toDouble(),
        pagototal: json["pagototal"],
        critopagada: json["critopagada"],
        hash: json["hash"],
      );
  factory GuardarCompra.fromdocument(DocumentSnapshot json) => GuardarCompra(
        timestampSting: json["timestamp_sting"],
        timestampint: json["timestampint"],
        uid: json["uid"],
        fichas: json["fichas"].toDouble(),
        diamantes: json["diamantes"].toDouble(),
        pagototal: json["pagototal"],
        critopagada: json["critopagada"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp_sting": timestampSting,
        "timestampint": timestampint,
        "uid": uid,
        "fichas": fichas,
        "diamantes": diamantes,
        "pagototal": pagototal,
        "critopagada": critopagada,
        "hash": hash,
      };
}
