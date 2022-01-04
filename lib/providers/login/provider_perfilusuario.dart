import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/pagues/models/usuario_model.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Provider_PerfilUsuario {
  final String _url_bbdd =
      "https://criptocoin-6e89c-default-rtdb.firebaseio.com/";

  final _pref_user = new PreferenciasUsuario(); //shared preferences

  Future<int> editar_usuario(Usuario usuario_model) async {
    //async
    //

    String direccionbddd = "Usuarios_clientes"; //NODO

    final Uri url_productos = Uri.parse(
        '$_url_bbdd/${direccionbddd}/${usuario_model.keyUsuario}.json'); //query

    //-http.post()
    final response1 = await http.put(url_productos,
        body: usuarioToJson(usuario_model)); //envia todo el cuarpo model

    final decodedata = json.decode(response1.body); //respuesta
    // print(' decode data =$decodedata');

    return 1;
  }

  //guardar firestore
  Future<int> guardardatosusandofirestore(
      Usuario usuario, BuildContext context) async {
    CollectionReference users_ref = FirebaseFirestore.instance
        .collection('Users')
        .doc('clients')
        .collection("info");
    if (usuario.keyUsuario != "") {
      await users_ref
          .doc(usuario.keyUsuario)
          .set(usuario.toJson())
          // .set({'full_name': "Mary Jane", 'age': 18})
          .then((value) => {
                //print(usuario.toJson())
                // ignore: avoid_print
                print("usuario ctualizado"),
                print(usuario.toJson()),
                Navigator.pushReplacementNamed(context, 'navegador'),
              })

          // ignore: invalid_return_type_for_catch_error
          .catchError((error) => print("Failed to add user: $error"));
      return 1;
    } else {
      print("falta informacion para guardar en firebase " +
          usuario.toJson().toString());
    }
    return 0;
  }

  Future<Usuario> recuperarusuario1(String uid, BuildContext context) async {
    var data;
    final DocumentReference users_ref = FirebaseFirestore.instance
        .collection('Users')
        .doc('clients')
        .collection("info")
        .doc(uid);

    await users_ref.get().then<dynamic>((DocumentSnapshot snapshot) async {
      data = Usuario.fromDocument(snapshot); //snapshot.data;

      print(data);

      /* setState(() {
        data = snapshot.data;
      });*/
    });
    return data;
    // var user=Usuario.fromDocument(json)
  }

//------------------------------aqui abajo son  lo de
/*
  //guardo el registro de comrpa
  Future agregarmicompra(Orders ordenes, BuildContext context) async {
    CollectionReference users_ref11 =
        FirebaseFirestore.instance.collection('Orders_users');
    await users_ref11
        .doc("usuarios")
        .collection(ordenes.keyUid)
        .doc(ordenes.buyOrder)
        .set(ordenes.toJson())
        // .set({'full_name': "Mary Jane", 'age': 18})
        .then((value) => {
              //print(usuario.toJson())
              print("registrar para usuario "),
              avisaradmins(ordenes, context)
              // Navigator.pushReplacementNamed(context, 'navegador'),
            })
        .catchError((error) => print("Failed to add user: $error"));
  }

  //VERIFICAR TABALA PARA ADMINISTRADORES (cuando eres usuario y terminaste el pago )
  Future avisaradmins(Orders ordenes, BuildContext context) async {
    CollectionReference users_ref22 =
        FirebaseFirestore.instance.collection('Orders_admin');
    //para los admin
    await users_ref22 //'Orders_admin
        .doc("peluqueuria")
        .collection("general")
        //.add(ordenes.toJson()) //anterior funciona casi 100% pero no me deja modificar un dato
        .doc(ordenes.buyOrder)
        .set(ordenes.toJson()) //probando este me funciono mejor de o esperado
        // .set(ordenes.toJson())
        // .set({'full_name': "Mary Jane", 'age': 18})
        .then((value) => {
              //print(usuario.toJson())
              print("registrado para admin "),
              // Navigator.pushReplacementNamed(context, 'navegador'),
            })
        .catchError((error) => print("Failed to add user: $error"));
  }
*/

}
