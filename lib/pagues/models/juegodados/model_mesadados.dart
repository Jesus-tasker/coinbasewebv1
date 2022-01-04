// To parse this JSON data, do
//
//     final mesadados = mesadadosFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Mesadados mesadadosFromJson(String str) => Mesadados.fromJson(json.decode(str));

String mesadadosToJson(Mesadados data) => json.encode(data.toJson());

class Mesadados {
  Mesadados({
    required this.partida,
    required this.tablero,
    required this.timestamp,
    required this.juego,
    required this.status,
    required this.terminada,
    required this.ganador,
    required this.apuestabase,
    required this.apuestafinal,
    required this.d1,
    required this.d2,
    required this.d3,
    required this.d4,
    required this.d5,
    required this.lanzamientoplayer,
  });

  String partida;
  String tablero;
  String timestamp;
  String juego;
  bool status;
  bool terminada;
  String ganador;
  double apuestabase;
  double apuestafinal;
  int d1;
  int d2;
  int d3;
  int d4;
  int d5;
  List<Lanzamientoplayer> lanzamientoplayer;

  factory Mesadados.fromJson(Map<String, dynamic> json) => Mesadados(
        partida: json["partida"],
        tablero: json["tablero"],
        timestamp: json["timestamp"],
        juego: json["juego"],
        status: json["status"],
        terminada: json["terminada"],
        ganador: json["ganador"],
        apuestabase: json["apuestabase"],
        apuestafinal: json["apuestafinal"],
        d1: json["d1"],
        d2: json["d2"],
        d3: json["d3"],
        d4: json["d4"],
        d5: json["d5"],
        lanzamientoplayer: List<Lanzamientoplayer>.from(
            json["lanzamientoplayer"]
                .map((x) => Lanzamientoplayer.fromJson(x))),
      );

  factory Mesadados.fromdocument(DocumentSnapshot json) => Mesadados(
        partida: json["partida"],
        tablero: json["tablero"],
        timestamp: json["timestamp"],
        juego: json["juego"],
        status: json["status"],
        terminada: json["terminada"],
        ganador: json["ganador"],
        apuestabase: json["apuestabase"],
        apuestafinal: json["apuestafinal"],
        d1: json["d1"],
        d2: json["d2"],
        d3: json["d3"],
        d4: json["d4"],
        d5: json["d5"],
        lanzamientoplayer: List<Lanzamientoplayer>.from(
            json["lanzamientoplayer"]
                .map((x) => Lanzamientoplayer.fromJson(x))),
      );
  factory Mesadados.map(Map json) => Mesadados(
        partida: json["partida"],
        tablero: json["tablero"],
        timestamp: json["timestamp"],
        juego: json["juego"],
        status: json["status"],
        terminada: json["terminada"],
        ganador: json["ganador"],
        apuestabase: json["apuestabase"],
        apuestafinal: json["apuestafinal"],
        d1: json["d1"],
        d2: json["d2"],
        d3: json["d3"],
        d4: json["d4"],
        d5: json["d5"],
        lanzamientoplayer: List<Lanzamientoplayer>.from(
            json["lanzamientoplayer"]
                .map((x) => Lanzamientoplayer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partida": partida,
        "tablero": tablero,
        "timestamp": timestamp,
        "juego": juego,
        "status": status,
        "terminada": terminada,
        "ganador": ganador,
        "apuestabase": apuestabase,
        "apuestafinal": apuestafinal,
        "d1": d1,
        "d2": d2,
        "d3": d3,
        "d4": d4,
        "d5": d5,
        "lanzamientoplayer":
            List<dynamic>.from(lanzamientoplayer.map((x) => x.toJson())),
      };
}

class Lanzamientoplayer {
  Lanzamientoplayer({
    required this.uid,
    required this.notifi,
    required this.timesplayer,
    required this.nombreplayer,
    required this.onplayer,
    required this.turno,
    required this.dado1,
    required this.dado2,
    required this.fichasplayer,
    required this.apuestaminima,
    required this.times_int,
  });

  String uid;
  String notifi;
  String timesplayer;
  String nombreplayer;
  bool onplayer;
  bool turno;
  double fichasplayer;
  int dado1;
  int dado2;
  double apuestaminima; //100
  int times_int;

  factory Lanzamientoplayer.fromJson(Map<String, dynamic> json) =>
      Lanzamientoplayer(
        uid: json["uid"],
        notifi: json["notifi"],
        timesplayer: json["timesplayer"],
        nombreplayer: json["nombreplayer"],
        onplayer: json["onplayer"],
        turno: json["turno"],
        dado1: json["dado1"],
        dado2: json["dado2"],
        fichasplayer: json["fichasplayer"],
        apuestaminima: json["apuestaminima"],
        times_int: json["times_int"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "notifi": notifi,
        "timesplayer": timesplayer,
        "nombreplayer": nombreplayer,
        "onplayer": onplayer,
        "turno": turno,
        "dado1": dado1,
        "dado2": dado2,
        "fichasplayer": fichasplayer,
        "apuestaminima": apuestaminima,
        "times_int": times_int,
      };
}
