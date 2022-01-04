// To parse this JSON data, do
//
//     final comprasmodel = comprasmodelFromJson(jsonString);

import 'dart:convert';

Comprasmodel comprasmodelFromJson(String str) =>
    Comprasmodel.fromJson(json.decode(str));

String comprasmodelToJson(Comprasmodel data) => json.encode(data.toJson());

class Comprasmodel {
  Comprasmodel({
    required this.moneda_name,
    required this.rutaimagen,
    required this.cantidad,
    required this.prefio,
  });

  String moneda_name;
  String rutaimagen;
  double cantidad;
  String prefio;

  factory Comprasmodel.fromJson(Map<String, dynamic> json) => Comprasmodel(
        moneda_name: json["moneda"],
        rutaimagen: json["rutaimagen"],
        cantidad: json["cantidad "].toDouble(),
        prefio: json["prefio"],
      );

  Map<String, dynamic> toJson() => {
        "moneda": moneda_name,
        "rutaimagen": rutaimagen,
        "cantidad ": cantidad,
        "prefio": prefio,
      };
}
