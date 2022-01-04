// To parse this JSON data, do
//
//     final criptoorder = criptoorderFromJson(jsonString);

import 'dart:convert';

Criptoorder criptoorderFromJson(String str) =>
    Criptoorder.fromJson(json.decode(str));

String criptoorderToJson(Criptoorder data) => json.encode(data.toJson());

/*{
  
    "uid":"eluide dle usuario",
    "buyOrder":"orden 1111",
    "name":"marcela melano",
    "unidfichas":"5000",
    "criptomonedaseleccionada":"bitcoin",
    "total":"1 Usd"
  } */
//solicuitud al backend
class Criptoorder {
  Criptoorder({
    required this.uid,
    required this.buyOrder,
    required this.name,
    required this.unidfichas,
    required this.criptomonedaseleccionada,
    required this.total,
  });

  String uid;
  String buyOrder;
  String name;
  String unidfichas;
  String criptomonedaseleccionada;
  String total;

  factory Criptoorder.fromJson(Map<String, dynamic> json) => Criptoorder(
        uid: json["uid"],
        buyOrder: json["buyOrder"],
        name: json["name"],
        unidfichas: json["unidfichas"],
        criptomonedaseleccionada: json["criptomonedaseleccionada"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "buyOrder": buyOrder,
        "name": name,
        "unidfichas": unidfichas,
        "criptomonedaseleccionada": criptomonedaseleccionada,
        "total": total,
      };
}
