// To parse this JSON data, do
//
//     final buscarpartida = buscarpartidaFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Buscarpartida buscarpartidaFromJson(String str) =>
    Buscarpartida.fromJson(json.decode(str));

String buscarpartidaToJson(Buscarpartida data) => json.encode(data.toJson());

class Buscarpartida {
  Buscarpartida({
    required this.numero,
    required this.timestamp,
    required this.nombre,
    required this.status,
    required this.jugadoreson,
  });

  String numero;
  String timestamp;
  String nombre;
  bool status;

  List<Jugadoreson> jugadoreson;

  factory Buscarpartida.fromJson(Map<String, dynamic> json) => Buscarpartida(
        numero: json["numero"],
        timestamp: json["timestamp"],
        nombre: json["nombre"],
        status: json["status"],
        jugadoreson: List<Jugadoreson>.from(
            json["jugadoreson"].map((x) => Jugadoreson.fromJson(x))),
      );
  factory Buscarpartida.fromdocument(DocumentSnapshot json) => Buscarpartida(
        numero: json["numero"],
        timestamp: json["timestamp"],
        nombre: json["nombre"],
        status: json["status"],
        jugadoreson: List<Jugadoreson>.from(
            json["jugadoreson"].map((x) => Jugadoreson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "numero": numero,
        "timestamp": timestamp,
        "nombre": nombre,
        "status": status,
        "jugadoreson": List<dynamic>.from(jugadoreson.map((x) => x.toJson())),
      };
}

class Jugadoreson {
  Jugadoreson({
    required this.uid,
    required this.foto,
    required this.timesplayer,
    required this.nombre,
    required this.onplayer,
    required this.notifi,
    required this.fichasplayerson,
  });

  String uid;
  String foto;
  String timesplayer;
  String nombre;
  String notifi;
  bool onplayer;
  double fichasplayerson;

  factory Jugadoreson.fromJson(Map<String, dynamic> json) => Jugadoreson(
        uid: json["uid"],
        timesplayer: json["timesplayer"],
        nombre: json["nombre"],
        onplayer: json["onplayer"],
        notifi: json["notifi"],
        fichasplayerson: json["fichasplayer"],
        foto: json["foto"],
      );
  factory Jugadoreson.fromdocument(DocumentSnapshot json) => Jugadoreson(
        uid: json["uid"],
        timesplayer: json["timesplayer"],
        nombre: json["nombre"],
        onplayer: json["onplayer"],
        notifi: json["notifi"],
        fichasplayerson: json["fichasplayer"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "timesplayer": timesplayer,
        "nombre": nombre,
        "onplayer": onplayer,
        "notifi": notifi,
        "fichasplayer": fichasplayerson,
        "foto": "foto",
      };
}

/*{
    "numero": "1",
     "timestamp": "time",
   "nombre": "dados",
    "status": true,
    "jugadoreson":[{
        "uid":"uid",
        "timesplayer":"time",
        "notifi":"asdfa",
        "nombre": "numero1111",
         "onplayer": false,
         "fichasplayer": fichasplayerson,
        
    }]
    
    
} */