import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/pagues/criptogame/v2/provider1_ibuscarpartida.dart';
import 'package:criptodadosweb/pagues/models/juegodados/guardar_compra.dart';
import 'package:criptodadosweb/pagues/models/pagos_bakcend/comprasmodel.dart';
import 'package:criptodadosweb/pagues/models/pagos_bakcend/cripto_responsebackend.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future guardar_pago_monedas(
    BuildContext context,
    CriptoResponse criptodata,
    String uid,
    String name,
    String fichas,
    String criptoselec,
    String totalt,
    String hash,
    Comprasmodel document) async {
  //  var fichasvirtualneuva=Fichas_virtuales(timestampSting: fichas, timestampint: fichas, fichas: fichas)
  //1. guarda el registro d ela compra
  //2. agrega las moendas al usuario  en prefabs
  var _prefabs = PreferenciasUsuario();
  double _fichas2_guardar = 0;
  double _diamante2_guardar = 0;

  SharedPreferences prefs_web = await SharedPreferences.getInstance();
  prefs_web.getBool('auth');
  var nombre = prefs_web.getString("nombreweb")!;
  var foto_c = prefs_web.getString("fotoweb")!;
  var _keytokken = prefs_web.getString("tokenweb")!;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getBool('auth');
  var _nombreshared = prefs.getString("nombreweb")!;
  var _foto_c_shared = prefs.getString("fotoweb")!;

  if (document.moneda_name == "Darckchip") {
    //app
    _prefabs.fichas_1 += document.cantidad;
    _fichas2_guardar = document.cantidad;

    //web
    prefs_web.setDouble("fichas", document.cantidad);
    prefs_web.setDouble("diamantes", document.cantidad);
  }
  if (document.moneda_name == "Diamond token") {
    //app
    _prefabs.diamantes += document.cantidad;
    _diamante2_guardar = document.cantidad;

    //web
    prefs_web.setDouble("fichas", document.cantidad);
    prefs_web.setDouble("diamantes", document.cantidad);
  }

  var _guardarcompra = GuardarCompra(
      timestampSting: criptoselec,
      timestampint: timestamp_obtenercodigo_int(),
      uid: _prefabs.token,
      fichas: _fichas2_guardar,
      diamantes: _diamante2_guardar,
      pagototal: criptodata.code, //1 usd
      critopagada: criptoselec,
      hash: criptodata.code);
  print(_guardarcompra.toJson());
  //hasta a qui bien

  var registro_compra1 = FirebaseFirestore.instance.collection('Coinbase');
  registro_compra1
      //.doc(_prefabs.token)
      .doc(_keytokken)
      .collection("Cash")
      .add(_guardarcompra.toJson())
      .then((value) {
    print("guardado en firebase");
    Navigator.popAndPushNamed(context, 'navegador');
  });
}
