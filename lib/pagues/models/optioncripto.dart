// To parse this JSON data, do
//
//     final opcionesbit = opcionesbitFromJson(jsonString);

import 'dart:convert';

Opcionesbit opcionesbitFromJson(String str) =>
    Opcionesbit.fromJson(json.decode(str));

String opcionesbitToJson(Opcionesbit data) => json.encode(data.toJson());

class Opcionesbit {
  Opcionesbit({
    required this.nombre,
    required this.foto,
  });

  String nombre;
  String foto;

  factory Opcionesbit.fromJson(Map<String, dynamic> json) => Opcionesbit(
        nombre: json["nombre"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "foto": foto,
      };
}
