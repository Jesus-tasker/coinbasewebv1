// To parse this JSON data, do
//
//     final deuda = deudaFromJson(jsonString);

import 'dart:convert';

Deuda deudaFromJson(String str) => Deuda.fromJson(json.decode(str));

String deudaToJson(Deuda data) => json.encode(data.toJson());

class Deuda {
  Deuda({
    required this.deuda,
  });

  List<DeudaElement> deuda;

  factory Deuda.fromJson(Map<String, dynamic> json) => Deuda(
        deuda: List<DeudaElement>.from(
            json["deuda"].map((x) => DeudaElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "deuda": List<dynamic>.from(deuda.map((x) => x.toJson())),
      };
}

class DeudaElement {
  DeudaElement({
    required this.cliente,
    required this.finanzas,
  });

  Cliente cliente;
  Finanzas finanzas;

  factory DeudaElement.fromJson(Map<String, dynamic> json) => DeudaElement(
        cliente: Cliente.fromJson(json["cliente"]),
        finanzas: Finanzas.fromJson(json["finanzas"]),
      );

  Map<String, dynamic> toJson() => {
        "cliente": cliente.toJson(),
        "finanzas": finanzas.toJson(),
      };
}

class Cliente {
  Cliente({
    required this.cedula,
    required this.nombre,
    required this.telefono,
    required this.direccion,
  });

  String cedula;
  String nombre;
  int telefono;
  String direccion;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        cedula: json["cedula"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        direccion: json["direccion"],
      );

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "nombre": nombre,
        "telefono": telefono,
        "direccion": direccion,
      };
}

class Finanzas {
  Finanzas({
    required this.fechainicio,
    required this.prestamoinicial,
    required this.deudapendiente,
    required this.interes,
  });

  String fechainicio;
  int prestamoinicial;
  bool deudapendiente;
  int interes;

  factory Finanzas.fromJson(Map<String, dynamic> json) => Finanzas(
        fechainicio: json["fechainicio"],
        prestamoinicial: json["prestamoinicial"],
        deudapendiente: json["deudapendiente"],
        interes: json["interes"],
      );

  Map<String, dynamic> toJson() => {
        "fechainicio": fechainicio,
        "prestamoinicial": prestamoinicial,
        "deudapendiente": deudapendiente,
        "interes": interes,
      };
}
/*{
   "deuda":[{"cliente":{"cedula":"123456","nombre":"jesus","telefono":3212125959,"direccion":"cra10 1234" },
       "finanzas":{"fechainicio":"05/09/2021","prestamoinicial":80000,"deudapendiente":true,"interes":10}}]
 
  
  
} */