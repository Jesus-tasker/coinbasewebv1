import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/pagues/criptogame/dados/jugardados.dart';
import 'package:criptodadosweb/pagues/criptogame/v2/jugardadosv2.dart';
import 'package:criptodadosweb/pagues/models/buscarpartida.dart';
import 'package:criptodadosweb/pagues/models/juegodados/model_mesadados.dart';
import 'package:criptodadosweb/pagues/models/optioncripto.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:criptodadosweb/utils/utils.dart';
import 'package:criptodadosweb/utils/utils_textos.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String timestamp_obtenercodigo() {
  DateTime currentPhoneDate = DateTime.now(); //DateTime.
  Timestamp myTimeStamp =
      Timestamp.fromDate(currentPhoneDate); //2021-09-22 14:42:52.544872
  DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime.
  return currentPhoneDate.toString();
}

int timestamp_obtenercodigo_int() {
  DateTime currentPhoneDate = DateTime.now(); //DateTime.
  Timestamp myTimeStamp =
      Timestamp.fromDate(currentPhoneDate); //2021-09-22 14:42:52.544872
  DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime.

  //var a = currentPhoneDate.toString();

  // return currentPhoneDate.microsecond; //927
  return currentPhoneDate.millisecondsSinceEpoch;
}

//
Future _buscarpartida(BuildContext context, String nombre, String uid,
    double fichasdejuego) async {
  final _pref_user = new PreferenciasUsuario();
  var busqueda1 = FirebaseFirestore.instance.collection('buscarpartida');
  //
  await busqueda1
      .orderBy('timestamp', descending: false)
      //.limitToLast(1)
      .get()
      .then((QuerySnapshot querySnapshot) {
    if (querySnapshot.docs.isEmpty) {
      print("carpeta vacia");
      //player 1 con datos reales el resto falsos
      var _jugador1 = Jugadoreson(
        uid: _pref_user.token,
        timesplayer: timestamp_obtenercodigo(),
        nombre: _pref_user.nombre,
        onplayer: true,
        fichasplayerson: fichasdejuego,
        notifi: _pref_user.token_notifi,
        foto: _pref_user.foto,
      );
      var _jugador2 = Jugadoreson(
          uid: "uid",
          timesplayer: timestamp_obtenercodigo(),
          nombre: "nombre",
          notifi: "notifiuid",
          fichasplayerson: 0,
          foto: "",
          onplayer: false);
      var _jugador3 = Jugadoreson(
          foto: "",
          uid: "uid",
          timesplayer: timestamp_obtenercodigo(),
          nombre: "nombre",
          notifi: "notifiuid",
          fichasplayerson: 0,
          onplayer: false);
      var _jugador4 = Jugadoreson(
          foto: "",
          uid: "uid",
          timesplayer: timestamp_obtenercodigo(),
          nombre: "nombre",
          notifi: "notifiuid",
          fichasplayerson: 0,
          onplayer: false);
      var _jugador5 = Jugadoreson(
          foto: "",
          uid: "uid",
          timesplayer: timestamp_obtenercodigo(),
          nombre: "nombre",
          notifi: "notifiuid",
          fichasplayerson: 0,
          onplayer: false);
      List<Jugadoreson> listaplayer = [];
      listaplayer.add(_jugador1);
      listaplayer.add(_jugador2);
      listaplayer.add(_jugador3);
      listaplayer.add(_jugador4);
      listaplayer.add(_jugador5);
      var _nuevapartida = Buscarpartida(
          numero: "1",
          timestamp: timestamp_obtenercodigo(),
          nombre: "dados",
          status: true,
          jugadoreson: listaplayer);
      //  busqueda1.add(_nuevapartida.toJson());
      busqueda1.doc("1").set(_nuevapartida.toJson());
      _buscarpartida(context, nombre, uid, fichasdejuego);
      //  busqueda1.doc("2").set(_nuevapartida.toJson());

      // busqueda1.add()
    } else {
      //parece que funciona
      print("si existe un snap!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      int count = 0;
      querySnapshot.docs.forEach((doc) {
        //------funcionan los json
        print(doc["timestamp"]); //oobtenido
        print(doc[
            "jugadoreson"]); // [{uid: uid111, timesplayer: 2021-09-22 14:42:52.544872, nombre: jesus, onplayer: true}]
        print(
            doc["jugadoreson"][0]["timesplayer"]); // 2021-09-22 14:42:52.544872
        // var  data = Buscarpartida.fromJson(doc.data());
        //----------
        var data = Buscarpartida.fromdocument(doc);
        print(data.status); //true
        print(data.numero);
        int jugadores = data.jugadoreson.length;
        print(jugadores); //1 a 5
        if (jugadores != 0 && jugadores <= 5) {
          //valor a enviar

          var _jugador1 = Jugadoreson(
              foto: _pref_user.foto,
              uid: _pref_user.token,
              timesplayer: timestamp_obtenercodigo(),
              nombre: _pref_user.nombre,
              onplayer: true,
              fichasplayerson: fichasdejuego,
              notifi: _pref_user.token_notifi);

          var _jugador2 = Jugadoreson(
              foto: "",
              uid: "uid",
              timesplayer: timestamp_obtenercodigo(),
              nombre: "nombre",
              notifi: "notifi",
              fichasplayerson: 0,
              onplayer: false);
          var _jugador3 = Jugadoreson(
              foto: "",
              uid: "uid",
              timesplayer: timestamp_obtenercodigo(),
              nombre: "nombre",
              notifi: "notifi",
              fichasplayerson: 0,
              onplayer: false);
          var _jugador4 = Jugadoreson(
              foto: "",
              uid: "uid",
              timesplayer: timestamp_obtenercodigo(),
              nombre: "nombre",
              notifi: "notifi",
              fichasplayerson: 0,
              onplayer: false);
          var _jugador5 = Jugadoreson(
              foto: "",
              uid: "uid",
              timesplayer: timestamp_obtenercodigo(),
              nombre: "nombre",
              notifi: "notifi",
              fichasplayerson: 0,
              onplayer: false);
          List<Jugadoreson> listaplayer = [];
          listaplayer.add(_jugador1);
          listaplayer.add(_jugador2);
          listaplayer.add(_jugador3);
          listaplayer.add(_jugador4);
          listaplayer.add(_jugador5);
          int one = int.parse(data.numero);
          one++;
          var _nuevapartida = Buscarpartida(
              numero: one.toString(),
              timestamp: timestamp_obtenercodigo(),
              nombre: "dados",
              status: true,
              jugadoreson: listaplayer);
          // data.jugadoreson.add(jugador1);
          // print(_nuevapartida.toJson());
          //----------------

          for (var i = 0; i < data.jugadoreson.length; i++) {
            if (data.jugadoreson[i].uid == _pref_user.token) {
              //encontro la partida lo enviamos a su respectivo pagina con el id
              print("partida encontrada " + data.numero);
              _navegar_push_partida(context, data);
              break;
            } else {
              //si una casilla esta vacia y navega a la pantalla con el id
              if (data.jugadoreson[i].onplayer == false &&
                  data.jugadoreson[i].uid != _pref_user.token) {
                var _partnew = data;
                _partnew.jugadoreson[i] = _jugador1;
                print("asignado a una  partida pos status  " +
                    data.numero +
                    " y " +
                    i.toString());
                busqueda1
                    .doc(data.numero)
                    .update(_partnew.toJson())
                    .then((value) => _navegar_push_partida(context, data));
                // Navigator.pop(context);

                break;
              }
              //si ya dio 5 bueltas y no hay espacio crea una nueva partida
              if (data.jugadoreson[i].uid != _pref_user.token &&
                  i == data.jugadoreson.length - 1 &&
                  data.jugadoreson[i].onplayer == true) {
                //partida llena
                print("partida llena ");

                busqueda1.doc(one.toString()).set(_nuevapartida.toJson());
                // .then((value) => _buscarpartida(context, nombre, uid));
                print("asignado a una  partida nueva " + one.toString());

                break;
              }
            }
          }
        }
      });
    }
  });
}

void _cargarsharedpreferencesweb(
    BuildContext context, Buscarpartida partidaasignada, double apuesta) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getBool('auth');
  nombre_c = prefs.getString("nombreweb")!;
  foto_c = prefs.getString("fotoweb")!;
  //fichasbit1 = prefs.getDouble("fichas")!;
  // diamantes = prefs.getDouble("diamantes")!;
  var _uid = prefs.getString("tokenweb")!;
  var _notifiuid = prefs.getString("notifiweb")!;

  //--
  var fichasfire = 0.0;
  var diamantesfire = 0.0;

  // fichasbit1 = prefs.getString("fichas")! as double;
  // diamantes = prefs.getString("diamantes")! as double;
  //busquemos el dinero que tengo realmente
  // print(nombre);
  var registro_compra1 = FirebaseFirestore.instance.collection('Coinbase');
  var busqueda1 = FirebaseFirestore.instance.collection('mesadados');
  await busqueda1
      .orderBy('timestamp', descending: false)
      //.where("partida", isEqualTo: partidaasignada.numero)
      .get()
      .then((QuerySnapshot querySnapshot) async {
    if (querySnapshot.docs.isEmpty) {
      //player 1 con datos reales el resto falsos
      var _jugador0 = Lanzamientoplayer(
          uid: _uid, //_pref_user.token,
          notifi: _notifiuid,
          timesplayer: timestamp_obtenercodigo(),
          times_int: timestamp_obtenercodigo_int(),
          nombreplayer: nombre_c,
          fichasplayer: apuesta,
          onplayer: true,
          turno: true,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      var _jugador1 = Lanzamientoplayer(
          uid: "uid",
          notifi: "notifi",
          timesplayer: "timestamp",
          times_int: 0,
          nombreplayer: "nombre ",
          fichasplayer: 0,
          onplayer: false,
          turno: false,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      var _jugador2 = Lanzamientoplayer(
          uid: "uid",
          notifi: "notifi",
          timesplayer: "timestamp",
          times_int: 0,
          nombreplayer: "nombre ",
          fichasplayer: 0,
          onplayer: false,
          turno: false,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      print("carpeta vacia");
      var _jugador3 = Lanzamientoplayer(
          uid: "uid",
          notifi: "notifi",
          timesplayer: "timestamp",
          times_int: 0,
          nombreplayer: "nombre ",
          fichasplayer: 0,
          onplayer: false,
          turno: false,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      var _jugador4 = Lanzamientoplayer(
          uid: "uid",
          notifi: "notifi",
          timesplayer: "timestamp",
          times_int: 0,
          nombreplayer: "nombre ",
          fichasplayer: 0,
          onplayer: false,
          turno: false,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      List<Lanzamientoplayer> listaplayer = [];
      listaplayer.add(_jugador0);
      listaplayer.add(_jugador1);
      listaplayer.add(_jugador2);
      listaplayer.add(_jugador3);
      listaplayer.add(_jugador4);

      int one = int.parse(partidaasignada.numero);
      one++;

      var _nuevapartida = Mesadados(
          partida: partidaasignada.numero,
          tablero: "1",
          timestamp: timestamp_obtenercodigo(),
          juego: "dados",
          status: false, //partida inciiada
          terminada: false, //partida termianda
          ganador: "no",
          apuestabase: 100,
          apuestafinal: 0,
          d1: 0,
          d2: 0,
          d3: 0,
          d4: 0,
          d5: 0,
          lanzamientoplayer: listaplayer);
      //  busqueda1.add(_nuevapartida.toJson());
      print(_nuevapartida.toString());
      busqueda1
          .doc("1")
          .set(_nuevapartida.toJson()); //set(_nuevapartida.toJson());
      print("partida creada");

      _buscarpartidav2_crearmesa(context, partidaasignada, apuesta);

      // busqueda1.add()
    } else {
      // _buscarpartidav3(context, partidaasignada);
      // 1. ya creada la apartida debemos obtenerla y mostrar los usuario - listo
      querySnapshot.docs.forEach((doc) {
        Mesadados _snap_mesa = Mesadados.fromdocument(doc);
        print("1 si existe partidas creadas!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        // print(_snap_mesa);

        var _mesadados_principal = Mesadados.fromJson(_snap_mesa.toJson());

        //2. obtener lista de jugadores on , no me funciono dle todo
        //_navegar_push_partidav2(context, _mesadados_principal, _mesadados_principal.partida);
        int usuarios_total =
            _mesadados_principal.lanzamientoplayer.length; //4 igual ya bienen

        List<Lanzamientoplayer> _listaplayers_on = [];

        //---validamos cada documento mesa ej mesa 3
        for (var i = 0; i < usuarios_total; i++) {
          var playeron = _mesadados_principal.lanzamientoplayer[i];

          //----el jugador estaba en esta partida?
          if (playeron.uid == _uid) {
            print("player en esta partida token=uid ");
            //_mesadados_principal.lanzamientoplayer[i].
            _navegar_push_partidav2(
                context, _mesadados_principal, _mesadados_principal.partida);
            break;
          } else if (playeron.uid != _uid && playeron.onplayer != true) {
            print("buscando espacio");
            //no esta en esta partida -buscand espacio para mi
            _listaplayers_on.add(playeron);
            //aqui esta aml formulado
            if (_listaplayers_on.length < 4) {
              //hay disponibilidad para otro jugador
              var _nuevojugador = Lanzamientoplayer(
                  uid: _uid,
                  notifi: _notifiuid,
                  timesplayer: timestamp_obtenercodigo(),
                  times_int: timestamp_obtenercodigo_int(),
                  nombreplayer: nombre_c,
                  fichasplayer: apuesta,
                  onplayer: true,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);

              _mesadados_principal.lanzamientoplayer[_listaplayers_on.length] =
                  _nuevojugador;
              //me agrego en la mesa
              update_mesa_player(context, _mesadados_principal);
              break;
            }
            if (_listaplayers_on.length == 5) {
              //crear una partida si los 4 espacios estan llenos
              print("creando nueva partida +1");
              var _jugador0 = Lanzamientoplayer(
                  uid: _uid,
                  notifi: _notifiuid,
                  timesplayer: timestamp_obtenercodigo(),
                  times_int: timestamp_obtenercodigo_int(),
                  nombreplayer: nombre_c,
                  fichasplayer: apuesta,
                  onplayer: true,
                  turno: true,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);
              var _jugador1 = Lanzamientoplayer(
                  uid: "uid",
                  notifi: "notifi",
                  timesplayer: "timestamp",
                  nombreplayer: "nombre ",
                  times_int: 0,
                  fichasplayer: 0,
                  onplayer: false,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);
              var _jugador2 = Lanzamientoplayer(
                  uid: "uid",
                  notifi: "notifi",
                  timesplayer: "timestamp",
                  times_int: 0,
                  nombreplayer: "nombre ",
                  fichasplayer: 0,
                  onplayer: false,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);

              var _jugador3 = Lanzamientoplayer(
                  uid: "uid",
                  notifi: "notifi",
                  timesplayer: "timestamp",
                  times_int: 0,
                  nombreplayer: "nombre ",
                  fichasplayer: 0,
                  onplayer: false,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);
              var _jugador4 = Lanzamientoplayer(
                  uid: "uid",
                  notifi: "notifi",
                  timesplayer: "timestamp",
                  nombreplayer: "nombre ",
                  fichasplayer: 0,
                  times_int: 0,
                  onplayer: false,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);
              List<Lanzamientoplayer> listaplayer = [];
              listaplayer.add(_jugador0);
              listaplayer.add(_jugador1);
              listaplayer.add(_jugador2);
              listaplayer.add(_jugador3);
              listaplayer.add(_jugador4);

              int one = int.parse(partidaasignada.numero);
              one++;

              var _nuevapartida = Mesadados(
                  partida: partidaasignada.numero,
                  tablero: one.toString(),
                  timestamp: timestamp_obtenercodigo(),
                  juego: "dados",
                  status: false, //partida inciiada
                  terminada: false, //partida termianda
                  ganador: "no",
                  apuestabase: 100,
                  apuestafinal: 0,
                  d1: 0,
                  d2: 0,
                  d3: 0,
                  d4: 0,
                  d5: 0,
                  lanzamientoplayer: listaplayer);
              //  busqueda1.add(_nuevapartida.toJson());
              //print(_nuevapartida.toString());
              nueva_partida_casillas_llenas(context, _nuevapartida, one);
              break;
            }
          }
        }

        //3 animar apuesta

        // 2 v2 -

        //falta a gregar foto de ellos
        // print(_mesadados_principal);
      });
    }
  });

/*
    //1/2 traer las fichas totales y luego los diamantes
    await registro_compra1
        .doc(_uid)
        //.doc()
        .collection("Cash")
        .where("fichas", isGreaterThan: 0)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        //guardar compra
        //aqui trato de leer toda la collecion de monedas compradas
        GuardarCompra _snap_mesa = GuardarCompra.fromdocument(element);

        fichasfire += _snap_mesa.fichas; //lo llogre 2800
        if (fichasbit1 != fichasfire) {
          fichasbit1 = fichasfire;
        }

        //  diamantes += _snap_mesa.diamantes;
        //funciona pero aun tiene un error  24/12/21
        //al recargar se actualiza los valores y no cambia no puedo entregar tanto dinero
      });
    });

    await registro_compra1
        .doc(_uid)
        //.doc()
        .collection("Cash")
        .where("diamantes", isGreaterThan: 0)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        //guardar compra
        //aqui trato de leer toda la collecion de monedas compradas
        GuardarCompra _snap_mesa = GuardarCompra.fromdocument(element);

        diamantesfire += _snap_mesa.fichas; //lo llogre 2800
        if (diamantes != diamantesfire) {
          diamantes = diamantesfire;
        }

        //  diamantes += _snap_mesa.diamantes;
        //funciona pero aun tiene un error  24/12/21
        //al recargar se actualiza los valores y no cambia no puedo entregar tanto dinero
      });
    });
*/
  // setState(() {});
}

//v2 creamos la partida directametne y pasamos la direccion en el stream hago todas las llamadas
Future _buscarpartidav2_crearmesa(
    BuildContext context, Buscarpartida partidaasignada, double apuesta) async {
  //final _pref_user = new PreferenciasUsuario();
  SharedPreferences _pref_user_web = await SharedPreferences.getInstance();
  //prefs.getBool('auth');
  nombre_c = _pref_user_web.getString("nombreweb")!;
  foto_c = _pref_user_web.getString("fotoweb")!;
  var _uid = _pref_user_web.getString("tokenweb")!;
  var _notifiuid = _pref_user_web.getString("tokenweb")!;

  var busqueda1 = FirebaseFirestore.instance.collection('mesadados');
  await busqueda1
      .orderBy('timestamp', descending: false)
      //.where("partida", isEqualTo: partidaasignada.numero)
      .get()
      .then((QuerySnapshot querySnapshot) async {
    if (querySnapshot.docs.isEmpty) {
      //player 1 con datos reales el resto falsos
      var _jugador0 = Lanzamientoplayer(
          uid: _uid,
          notifi: _notifiuid,
          timesplayer: timestamp_obtenercodigo(),
          times_int: timestamp_obtenercodigo_int(),
          nombreplayer: nombre_c,
          fichasplayer: apuesta,
          onplayer: true,
          turno: true,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      var _jugador1 = Lanzamientoplayer(
          uid: "uid",
          notifi: "notifi",
          timesplayer: "timestamp",
          times_int: 0,
          nombreplayer: "nombre ",
          fichasplayer: 0,
          onplayer: false,
          turno: false,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      var _jugador2 = Lanzamientoplayer(
          uid: "uid",
          notifi: "notifi",
          timesplayer: "timestamp",
          times_int: 0,
          nombreplayer: "nombre ",
          fichasplayer: 0,
          onplayer: false,
          turno: false,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      print("carpeta vacia");
      var _jugador3 = Lanzamientoplayer(
          uid: "uid",
          notifi: "notifi",
          timesplayer: "timestamp",
          times_int: 0,
          nombreplayer: "nombre ",
          fichasplayer: 0,
          onplayer: false,
          turno: false,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      var _jugador4 = Lanzamientoplayer(
          uid: "uid",
          notifi: "notifi",
          timesplayer: "timestamp",
          times_int: 0,
          nombreplayer: "nombre ",
          fichasplayer: 0,
          onplayer: false,
          turno: false,
          apuestaminima: 0,
          dado1: 0,
          dado2: 0);
      List<Lanzamientoplayer> listaplayer = [];
      listaplayer.add(_jugador0);
      listaplayer.add(_jugador1);
      listaplayer.add(_jugador2);
      listaplayer.add(_jugador3);
      listaplayer.add(_jugador4);

      int one = int.parse(partidaasignada.numero);
      one++;

      var _nuevapartida = Mesadados(
          partida: partidaasignada.numero,
          tablero: "1",
          timestamp: timestamp_obtenercodigo(),
          juego: "dados",
          status: false, //partida inciiada
          terminada: false, //partida termianda
          ganador: "no",
          apuestabase: 100,
          apuestafinal: 0,
          d1: 0,
          d2: 0,
          d3: 0,
          d4: 0,
          d5: 0,
          lanzamientoplayer: listaplayer);
      //  busqueda1.add(_nuevapartida.toJson());
      print(_nuevapartida.toString());
      busqueda1
          .doc("1")
          .set(_nuevapartida.toJson()); //set(_nuevapartida.toJson());
      print("partida creada");

      _cargarsharedpreferencesweb(context, partidaasignada, apuesta);
      // _buscarpartidav2_crearmesa(context, partidaasignada, apuesta);

      // busqueda1.add()
    } else {
      // _buscarpartidav3(context, partidaasignada);
      // 1. ya creada la apartida debemos obtenerla y mostrar los usuario - listo
      querySnapshot.docs.forEach((doc) {
        Mesadados _snap_mesa = Mesadados.fromdocument(doc);
        print("1 si existe partidas creadas!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        // print(_snap_mesa);

        var _mesadados_principal = Mesadados.fromJson(_snap_mesa.toJson());

        //2. obtener lista de jugadores on , no me funciono dle todo
        //_navegar_push_partidav2(context, _mesadados_principal, _mesadados_principal.partida);
        int usuarios_total =
            _mesadados_principal.lanzamientoplayer.length; //4 igual ya bienen

        List<Lanzamientoplayer> _listaplayers_on = [];

        //---validamos cada documento mesa ej mesa 3
        for (var i = 0; i < usuarios_total; i++) {
          var playeron = _mesadados_principal.lanzamientoplayer[i];

          //----el jugador estaba en esta partida?
          if (playeron.uid == _uid) {
            print("player en esta partida token=uid ");
            //_mesadados_principal.lanzamientoplayer[i].
            _navegar_push_partidav2(
                context, _mesadados_principal, _mesadados_principal.partida);
            break;
          } else if (playeron.uid != _uid && playeron.onplayer != true) {
            print("buscando espacio");
            //no esta en esta partida -buscand espacio para mi
            _listaplayers_on.add(playeron);
            //aqui esta aml formulado
            if (_listaplayers_on.length < 4) {
              //hay disponibilidad para otro jugador
              var _nuevojugador = Lanzamientoplayer(
                  uid: _uid,
                  notifi: _notifiuid,
                  timesplayer: timestamp_obtenercodigo(),
                  times_int: timestamp_obtenercodigo_int(),
                  nombreplayer: nombre_c,
                  fichasplayer: apuesta,
                  onplayer: true,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);

              _mesadados_principal.lanzamientoplayer[_listaplayers_on.length] =
                  _nuevojugador;
              //me agrego en la mesa
              update_mesa_player(context, _mesadados_principal);
              break;
            }
            if (_listaplayers_on.length == 5) {
              //crear una partida si los 4 espacios estan llenos
              print("creando nueva partida +1");
              var _jugador0 = Lanzamientoplayer(
                  uid: _uid,
                  notifi: _notifiuid,
                  timesplayer: timestamp_obtenercodigo(),
                  times_int: timestamp_obtenercodigo_int(),
                  nombreplayer: nombre_c,
                  fichasplayer: apuesta,
                  onplayer: true,
                  turno: true,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);
              var _jugador1 = Lanzamientoplayer(
                  uid: "uid",
                  notifi: "notifi",
                  timesplayer: "timestamp",
                  nombreplayer: "nombre ",
                  times_int: 0,
                  fichasplayer: 0,
                  onplayer: false,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);
              var _jugador2 = Lanzamientoplayer(
                  uid: "uid",
                  notifi: "notifi",
                  timesplayer: "timestamp",
                  times_int: 0,
                  nombreplayer: "nombre ",
                  fichasplayer: 0,
                  onplayer: false,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);

              var _jugador3 = Lanzamientoplayer(
                  uid: "uid",
                  notifi: "notifi",
                  timesplayer: "timestamp",
                  times_int: 0,
                  nombreplayer: "nombre ",
                  fichasplayer: 0,
                  onplayer: false,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);
              var _jugador4 = Lanzamientoplayer(
                  uid: "uid",
                  notifi: "notifi",
                  timesplayer: "timestamp",
                  nombreplayer: "nombre ",
                  fichasplayer: 0,
                  times_int: 0,
                  onplayer: false,
                  turno: false,
                  apuestaminima: 0,
                  dado1: 0,
                  dado2: 0);
              List<Lanzamientoplayer> listaplayer = [];
              listaplayer.add(_jugador0);
              listaplayer.add(_jugador1);
              listaplayer.add(_jugador2);
              listaplayer.add(_jugador3);
              listaplayer.add(_jugador4);

              int one = int.parse(partidaasignada.numero);
              one++;

              var _nuevapartida = Mesadados(
                  partida: partidaasignada.numero,
                  tablero: one.toString(),
                  timestamp: timestamp_obtenercodigo(),
                  juego: "dados",
                  status: false, //partida inciiada
                  terminada: false, //partida termianda
                  ganador: "no",
                  apuestabase: 100,
                  apuestafinal: 0,
                  d1: 0,
                  d2: 0,
                  d3: 0,
                  d4: 0,
                  d5: 0,
                  lanzamientoplayer: listaplayer);
              //  busqueda1.add(_nuevapartida.toJson());
              //print(_nuevapartida.toString());
              nueva_partida_casillas_llenas(context, _nuevapartida, one);
              break;
            }
          }
        }

        //3 animar apuesta

        // 2 v2 -

        //falta a gregar foto de ellos
        // print(_mesadados_principal);
      });
    }
  });
}

Future update_mesa_player(BuildContext context, Mesadados mesadados) async {
  var busqueda1 = FirebaseFirestore.instance.collection('mesadados');
  await busqueda1
      .doc(mesadados.tablero)
      .update(mesadados.toJson())
      .then((value) {
    print("busqueda dd over");
    _navegar_push_partidav2(context, mesadados, mesadados.partida);
  }); //set(_nuevapartida.toJson());
}

Future nueva_partida_casillas_llenas(
    BuildContext context, Mesadados nuevapartida, int one) async {
  var busqueda1 = FirebaseFirestore.instance.collection('mesadados');
  await busqueda1.doc(one.toString()).set(nuevapartida.toJson()).then((value) {
    print("partida creada 2");
    _navegar_push_partidav2(context, nuevapartida, nuevapartida.partida);
  }); //set(_nuevapartida.toJson());; //set(_nuevapartida.toJson());
}

//ya no la uso
void _navegar_push_partida(BuildContext contex, Buscarpartida numero) {
  //siguiente widget
  Navigator.pushAndRemoveUntil(
    contex,
    MaterialPageRoute(builder: (context) => Jugardados(numero)),
    (r) => false,
  ).then(
    (value) => Navigator.pop(contex),
  );

  //playdados
}

//nueva y mejorada
void _navegar_push_partidav2(
    BuildContext contex, Mesadados mesa, String mesainicial) {
  //siguiente widget
  Navigator.pushAndRemoveUntil(
    contex,
    MaterialPageRoute(
        builder: (context) => Jugardadosv22(mesainicial.toString(), mesa)),
    (r) => false,
  ).then(
    (value) => Navigator.pop(contex),
  );

  //playdados
}

Future<String> crearpartida() async {
  return "numero de partida";
}

//referencia
void guardarfirebase(BuildContext context) {
  print("firestore");
  Firebase.initializeApp();
  FirebaseFirestore db = FirebaseFirestore.instance;
  Opcionesbit op = new Opcionesbit(nombre: "jesus", foto: "foto");
  db.collection("partida").add(op.toJson());
}

dialog_buscandopartida(BuildContext context, int i, double fichas) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // Background color
    barrierDismissible: false,
    barrierLabel: 'Dialog',
    transitionDuration: Duration(
        milliseconds:
            100), // How long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      double _apuesta = fichas; //fichas para entrar a aapostar ene l juego
      // Makes widget fullscreen
      return SizedBox.expand(
        child: Column(
          children: <Widget>[
            //titulos
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        util_limit("Moneda:fichas de casino  "),
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage("assets/2logoficha.png"),
                        )
                      ],
                    ),
                    util_limit("apuesta minima 500 fichas "),
                  ],
                ),
              ),
            ),
            //ficha
            Expanded(
              flex: 5,
              child: SizedBox.expand(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/2logoficha.png"),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: util_texts_black2_agregattamano(
                              fichas.toString(), 1)),
                    ],
                  ),
                ),
              ), //aqui mostraba el logo de flutter
            ),
            //boton
            Expanded(
              flex: 1,
              child: SizedBox.expand(
                child: ElevatedButton(
                  onPressed: //() => Navigator.pop(context),
                      () {
                    if (_apuesta != 0 && _apuesta >= 490 && _apuesta < 10000) {
                      //   // Navigator.pop(context);
                      // _buscarpartida(context, "jesus", "uid111", fichas);
                      var _nuevapartida = Buscarpartida(
                          numero: "1",
                          timestamp: timestamp_obtenercodigo(),
                          nombre: "dados",
                          status: true,
                          jugadoreson: []);
                      _buscarpartidav2_crearmesa(context, _nuevapartida,
                          _apuesta); //aqui lo cambiamos por una mesa
                    } else {
                      mostraralerta(context, "fichas insuficientes !");
                    }
                  },
                  child: Text(
                    'Buscar Partida',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
