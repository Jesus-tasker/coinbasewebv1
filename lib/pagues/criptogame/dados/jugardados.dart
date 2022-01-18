import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/pagues/criptogame/dados/provider_dados_dagme.dart';
import 'package:criptodadosweb/pagues/criptogame/v2/provider1_ibuscarpartida.dart';
import 'package:criptodadosweb/pagues/models/buscarpartida.dart';
import 'package:criptodadosweb/pagues/models/juegodados/model_mesadados.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:criptodadosweb/utils/utils_textos.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_xlider/flutter_xlider.dart';

//para entrar en la partida
List<Jugadoreson> player = [];
var _partida_selec = Buscarpartida(
    numero: "numero",
    timestamp: "timestamp",
    nombre: "nombre",
    status: false,
    jugadoreson: player); //por ahoora slo el nmero ya vere quemas agrego

var _mesadados_principal = Mesadados(
    partida: "1",
    tablero: "1",
    timestamp: timestamp_obtenercodigo(),
    juego: "dados",
    status: true,
    terminada: false,
    ganador: "no",
    apuestabase: 100,
    apuestafinal: 0,
    d1: 0,
    d2: 0,
    d3: 0,
    d4: 0,
    d5: 0,
    lanzamientoplayer: []);
List<Lanzamientoplayer> _listaplayers_on = [];

int _contador_tiempo = 1000;
bool _mostrarapuesta = false;

//para entrar ane la partida
class Jugardados extends StatefulWidget {
  Jugardados(this.partida_selec, {Key? key}) : super(key: key);
  Buscarpartida partida_selec;

  @override
  _JugardadosState createState() => _JugardadosState();
}

class _JugardadosState extends State<Jugardados> {
  //String _partida_selec=widget.partida_selec.toString();
  //2 jugadores
  //6 dados
  //aun no primero vamos a provar como pagar
  //uid1 uid2
  Color color_principal = Color.fromRGBO(150, 250, 200, 0.2);
  //slide
  double _valorslider = 100.0;
  bool _bloquearcheck = false;

  @override
  Widget build(BuildContext context) {
    _partida_selec = widget.partida_selec;
    //_iniciarpartida(context, _partida_selec);
    _buscarpartidav2(context, _partida_selec); //v2 para mantener aqui el dato
    // TODO: implement build
    return new Scaffold(
      body: OrientationBuilder(builder: (context, orientacion) {
        // SI LA ORIENTACION ESTA EN VERTICAL
        if (orientacion == Orientation.portrait) {
          return new Scaffold(
            /*appBar: AppBar(
              title: Text("ORIENTACIÓN VERTICAL"),
              backgroundColor: Colors.green,
            ),*/
            body: _00_vertical_normal(context),
          );
        } else {
          // SI LA ORIENTACION ESTA EN HORIZONTAL

          return new Scaffold(
            appBar: AppBar(
              title: Text("ORIENTACIÓN HORIZONTAL"),
              backgroundColor: Colors.red,
            ),
            body: new Container(
              padding: EdgeInsets.all(10.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("Texto en HORIZONTAL"),
                    ],
                  ),
                  new RaisedButton(
                      child: Text("HORIZONTAL"),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {}),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  // SI LA ORIENTACION ESTA EN VERTICAL
  late Timer _timer = Timer(Duration(), () {});
  int minut = 1;

//jugador 1
  void startTimer(
      Lanzamientoplayer lanzamientoplayer, Mesadados mesadados_principal) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_contador_tiempo == 0) {
          if (lanzamientoplayer.uid == _pref_user.token) {
            _mostrarapuesta = false; //quitamos el alerta de unirse
            player_no_aposto(lanzamientoplayer, mesadados_principal);
          } else {
            jugadores_nojugo(lanzamientoplayer, mesadados_principal);
          }
          setState(() {
            timer.cancel();

            //actualizar
          });
        } else {
          setState(() {
            _contador_tiempo--;
          });
        }
      },
    );
  }

////
  Widget _00_vertical_normal(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    Widget pantallanormal = Container(
      child: Stack(
        children: <Widget>[
          _1fondo_pantalla(context),
          _2mesa_tablero(context),
          _3_lista_jugadores(context),
          //4_principal
          Container(
            //padding: EdgeInsets.only(bottom: 200),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(top: _screensize.height * 0.75),

            child: Column(
              children: [
                util_texts("340"),
                _4_jugadorprincipal(context, "jesus", 5000),
              ],
            ),
          ), //co
          //5 botones
          Container(
            // padding: EdgeInsets.only(bottom: 60),
            padding: EdgeInsets.only(right: 20),
            //alignment: Alignment.bottomRight,
            // padding: EdgeInsets.only(top: _screensize.height * 0.5),

            child:
                // util_texts("340"),

                _5_botonesdame(context),
            // _4_jugadorprincipal(context, "jesus", 5000),
          ),
          //6 aumentar apuesta
          Container(
            //padding: EdgeInsets.only(top: _screensize.height * 0.4),
            alignment: Alignment.bottomLeft,
            child: _6_crearslider_cash(context),
          ),
//7 centro de la mesa
          Container(
            padding: EdgeInsets.only(
                top: _screensize.height * 0.2, left: _screensize.width * 0.25),
            alignment: Alignment.center,
            child: _7_mesa_centro(context),
          ),
          //co
        ],
      ),
    );
    return pantallanormal;
  }

  Widget _1fondo_pantalla(BuildContext context) {
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    return Expanded(
      child: Container(
          //CONTENEDOR CON EL SWIPE <..> PARA MOVERSE
          //le decimos el tamaño que debe tener y donde sacar las imagens
          width: double.infinity, //usar tood el ancho
          padding: EdgeInsets.only(top: 10), //pading superos
          //width: _screensize.width * 0.7 , //que el tamaño sea el 70% de ancho en la pantalla
          height: double.infinity,

          /// _screensize.height * 0.5, //la mitad del dispitivo

          child: ClipRRect(
              //clip reect para poner el border y dento ponemos la imagen
              borderRadius: BorderRadius.circular(20),
              child:
                  //new Image.network("http://via.placeholder.com/350x150", fit: BoxFit.cover,
                  //fit se adapta a las dimensiones que tiene,
                  GestureDetector(
                //wiget para pasar entre activityes
                onTap: () {
                  print('tappp');
                },
                child: Container(
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        child: FadeInImage(
                          image: NetworkImage(
                              "https://wallpapercave.com/wp/tOhBZQr.jpg"), // peliculas_list[index].getposterimage()
                          placeholder: AssetImage('assets/no-image.png'),
                          fit: BoxFit
                              .cover, //reparo el error del controno medio ciruclar
                        ),
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.topCenter,
                        color: Colors.white38,
                        child: ClipRRect(
                          //clip reect para poner el border y dento ponemos la imagen
                          borderRadius: BorderRadius.circular(20),
                          child: Text(
                            _partida_selec.numero,
                            //textScaleFactor: 24,
                            textScaleFactor: 2.5,

                            overflow: TextOverflow
                                .ellipsis, //cuando el texto no cabe pone puntitos
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                      //
                      Container(
                        //  height: 100,
                        alignment: Alignment.bottomCenter,
                        // color: Colors.white38,
                        child: ClipRRect(
                          //clip reect para poner el border y dento ponemos la imagen
                          borderRadius: BorderRadius.circular(20),
                          child: Text(
                            "description",
                            //textScaleFactor: 24,
                            textScaleFactor: 2,

                            overflow: TextOverflow
                                .ellipsis, //cuando el texto no cabe pone puntitos
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget _2mesa_tablero(BuildContext context) {
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    return ClipRRect(
      //clip reect para poner el border y dento ponemos la imagen
      borderRadius: BorderRadius.circular(10),
      child: Expanded(
        child: Container(
          // color: Colors.brown.shade900, //cambia el fondo no las puntas blancas d ela mesa
          //CONTENEDOR CON EL SWIPE <..> PARA MOVERSE
          //le decimos el tamaño que debe tener y donde sacar las imagens
          width: double.infinity, //usar tood el ancho
          //width: _screensize.width * 0.7 , //que el tamaño sea el 70% de ancho en la pantalla
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(40, 90, 40, 100), //pading superos

          /// _screensize.height * 0.5, //la mitad del dispitivo

          child: Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
                side: BorderSide(width: 7, color: Colors.white38)),
            child: ClipRRect(

                //clip reect para poner el border y dento ponemos la imagen
                borderRadius: BorderRadius.circular(80),
                child: Container(
                  color: Colors.brown[900],

                  width: double.infinity, //usar tood el ancho
                  //width: _screensize.width * 0.7 , //que el tamaño sea el 70% de ancho en la pantalla
                  height: double.infinity,
                  // padding:EdgeInsets.fromLTRB(40, 100, 40, 100), //pading superos

                  // padding: EdgeInsets.all(15),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        // width: double.infinity,

                        child: Image(
                            image: AssetImage("assets/1fondoverde.png"),
                            fit: BoxFit.cover),
                      ),

                      Visibility(
                        child: Container(
                          //padding: EdgeInsets.only(left: 30),
                          alignment: Alignment.center, //no
                          // width: double.infinity,
                          // color: Colors.white38,
                          child: Row(
                            children: [
                              ClipRect(
                                child: Icon(Icons.casino),
                              ),
                              util_texts_black2_agregattamano("Raised press", 3)
                            ],
                          ),
                        ),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: _mostrarapuesta, //show
                      ),
                      //   AssetImage("assets/dado1_cara.png")
                      /* Container(
                        height: double.infinity,
                        child: FadeInImage(
                          image: NetworkImage(
                              "https://images.freeimages.com/images/large-previews/4dc/free-casino-table-cloth-texture-1637741.jpg"), // peliculas_list[index].getposterimage()
                          placeholder: AssetImage('assets/jar-loading.gif'),
                          fit: BoxFit
                              .cover, //reparo el error del controno medio ciruclar
                        ),
                      ),*/
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  _3_lista_jugadores(BuildContext context) {
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    final _pref_user = new PreferenciasUsuario();
    var user1, user2, user3, user4;
    List listausers;

    bool _verdaddos = false;

    //players on teoria no confirmada  pero puede servir
    List<Lanzamientoplayer> _lista_otrosplayers = [];
    //listadeusuarios que estan on
    for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
      //1si estan conectados
      if (_mesadados_principal.lanzamientoplayer[i].onplayer != false) {
        if (_mesadados_principal.lanzamientoplayer[i].uid != _pref_user.token) {
          //2. turno de quien le toca

          _lista_otrosplayers.add(_mesadados_principal.lanzamientoplayer[i]);
        }
      }
    }
    //con esto quedan en orden los jugadores que entran on
    /*  if (_lista_otrosplayers.length < 4) {
      for (var i = 0; i < _lista_otrosplayers.length; i++) {
        //1si estan conectados
        if (_lista_otrosplayers[i].onplayer != false) {
          if (_lista_otrosplayers[i].uid != _pref_user.token) {
            _lista_otrosplayers.add(_lista_otrosplayers[i]);
          }
        }
      }
    }*/
    //lista de los jugadores y su

    if (_lista_otrosplayers.length > 2) {
      //aqui muestroa  los otros jugadores
      //widgets

      Widget player1 = Container(
        //padding: EdgeInsets.only(bottom: 200),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top: 200),

        child: Column(
          children: [
            _jugador1(context, _mesadados_principal.lanzamientoplayer[0]),
            util_texts(_mesadados_principal.lanzamientoplayer[0].apuestaminima
                .toString()),
            Visibility(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.bottomCenter, //no
                // width: double.infinity,
                // color: Colors.white38,
                child: Row(
                  children: [
                    ClipRect(
                      child: Icon(Icons.casino),
                    ),
                    ClipRect(
                      child: Icon(Icons.casino),
                    ),
                  ],
                ),
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: true,
            ),
          ],
        ),
      ); //contrincante1
      Widget player2 = Container(
        //padding: EdgeInsets.only(bottom: 200),

        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(top: 400),
        child: Column(
          children: [
            _jugador1(context, _mesadados_principal.lanzamientoplayer[1]),
            util_texts(_mesadados_principal.lanzamientoplayer[1].apuestaminima
                .toString()),
          ],
        ),
      ); //contr
      Widget playe3 = Container(
        //padding: EdgeInsets.only(bottom: 200),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(top: 200),

        child: Column(
          children: [
            _jugador1(context, _mesadados_principal.lanzamientoplayer[2]),
            util_texts(_mesadados_principal.lanzamientoplayer[2].apuestaminima
                .toString()),
          ],
        ),
      ); //contrincante1
      Widget player4 = Container(
        //padding: EdgeInsets.only(bottom: 200),

        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(top: 400),
        child: Column(
          children: [
            _jugador1(context, _mesadados_principal.lanzamientoplayer[3]),
            util_texts(_mesadados_principal.lanzamientoplayer[3].apuestaminima
                .toString()),
          ],
        ),
      ); //contr

      if (_lista_otrosplayers[0] != null) {
        if (_lista_otrosplayers[0].apuestaminima != 0) {
          //jugador aun no se ve
          // _color_backgroub = Colors.red;
          _verdaddos = true;
        }
        player1 = Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
              side: BorderSide(width: 7, color: Colors.white38)),
          child: Container(
            //padding: EdgeInsets.only(bottom: 200),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 200),

            child: Column(
              children: [
                _jugador1(context, _lista_otrosplayers[0]),
                util_texts(_lista_otrosplayers[0].apuestaminima.toString()),
              ],
            ),
          ),
        ); //contrincant

      }
      if (_lista_otrosplayers[1] != null) {
        player2 = Container(
          //padding: EdgeInsets.only(bottom: 200),

          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(top: 400),
          child: Column(
            children: [
              _jugador1(context, _mesadados_principal.lanzamientoplayer[0]),
              util_texts(_lista_otrosplayers[1].apuestaminima.toString()),
            ],
          ),
        ); //contr

      }
      if (_lista_otrosplayers[2] != null) {
        playe3 = Container(
          //padding: EdgeInsets.only(bottom: 200),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(top: 200),

          child: Column(
            children: [
              _jugador1(context, _lista_otrosplayers[2]),
              util_texts(_lista_otrosplayers[2].apuestaminima.toString()),
            ],
          ),
        ); //contrincante1

      }
      if (_lista_otrosplayers[3] != null) {
        player4 = Container(
          //padding: EdgeInsets.only(bottom: 200),

          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(top: 400),
          child: Column(
            children: [
              _jugador1(context, _lista_otrosplayers[3]),
              util_texts(_lista_otrosplayers[3].apuestaminima.toString()),
            ],
          ),
        );
      }

      int vacios = _lista_otrosplayers.length;
      for (var i = 0; i < _lista_otrosplayers.length; i++) {}

      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Expanded(
          child: Container(
              width: double.infinity, //usar tood el ancho
              height: double.infinity,

              /// _screensize.height * 0.5, //la mitad del dispitivo

              child: ClipRRect(

                  //clip reect para poner el border y dento ponemos la imagen
                  borderRadius: BorderRadius.circular(100),
                  child: GestureDetector(
                    //wiget para pasar entre activityes
                    onTap: () {
                      print('tappp');
                    },
                    child: Container(
                      width: double.infinity, //usar tood el ancho
                      //width: _screensize.width * 0.7 , //que el tamaño sea el 70% de ancho en la pantalla
                      height: double.infinity,
                      // padding:EdgeInsets.fromLTRB(40, 100, 40, 100), //pading superos

                      padding: EdgeInsets.all(15),
                      child: Stack(
                        children: <Widget>[
                          player1,
                          player2,
                          playe3,
                          //enemigo 1 a la  izquierda arriba
                          //derecha
                        ],
                      ),
                    ),
                  ))),
        ),
      );
    } else {
      //icono dados prefabricado
      Widget _iconsdados = Visibility(
        child: Container(
          //padding: EdgeInsets.only(top: 30),
          //  alignment: Alignment.bottomCenter, //no
          // width: double.infinity,
          // color: Colors.white38,
          child: Row(
            children: [
              ClipRect(
                child: Icon(Icons.casino),
              ),
              ClipRect(
                child: Icon(Icons.casino),
              ),
            ],
          ),
        ),
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: false,
      );
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Expanded(
          child: Container(
              width: double.infinity, //usar tood el ancho
              height: double.infinity,

              /// _screensize.height * 0.5, //la mitad del dispitivo

              child: ClipRRect(

                  //clip reect para poner el border y dento ponemos la imagen
                  borderRadius: BorderRadius.circular(100),
                  child: GestureDetector(
                    //wiget para pasar entre activityes
                    onTap: () {
                      print('tappp');
                    },
                    child: Container(
                      width: double.infinity, //usar tood el ancho
                      //width: _screensize.width * 0.7 , //que el tamaño sea el 70% de ancho en la pantalla
                      height: double.infinity,
                      // padding:EdgeInsets.fromLTRB(40, 100, 40, 100), //pading superos

                      padding: EdgeInsets.all(15),
                      child: Stack(
                        children: <Widget>[
                          //enemigo 1 a la  izquierda arriba
                          Container(
                            //padding: EdgeInsets.only(bottom: 200),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 200),

                            child: Column(
                              children: [
                                _jugador1(context,
                                    _mesadados_principal.lanzamientoplayer[0]),
                                util_texts(_mesadados_principal
                                    .lanzamientoplayer[0].apuestaminima
                                    .toString()),
                                //_iconsdados,
                              ],
                            ),
                          ), //contrincante1
                          Container(
                            //padding: EdgeInsets.only(bottom: 200),

                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(top: 400),
                            child: Column(
                              children: [
                                _jugador1(context,
                                    _mesadados_principal.lanzamientoplayer[1]),
                                util_texts(_mesadados_principal
                                    .lanzamientoplayer[1].apuestaminima
                                    .toString()),
                              ],
                            ),
                          ), //contr
                          //derecha
                          Container(
                            //padding: EdgeInsets.only(bottom: 200),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(top: 200),

                            child: Column(
                              children: [
                                _jugador1(context,
                                    _mesadados_principal.lanzamientoplayer[2]),
                                util_texts(_mesadados_principal
                                    .lanzamientoplayer[2].apuestaminima
                                    .toString()),
                              ],
                            ),
                          ), //contrincante1
                          Container(
                            //padding: EdgeInsets.only(bottom: 200),

                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(top: 400),
                            child: Column(
                              children: [
                                _jugador1(context,
                                    _mesadados_principal.lanzamientoplayer[3]),
                                util_texts(_mesadados_principal
                                    .lanzamientoplayer[3].apuestaminima
                                    .toString()),
                              ],
                            ),
                          ), //contr
                        ],
                      ),
                    ),
                  ))),
        ),
      );
    }
  }

  Widget _jugador1(BuildContext context, Lanzamientoplayer lanzamientoplayer) {
    String nombre = lanzamientoplayer.nombreplayer;
    double fichas = lanzamientoplayer.fichasplayer;
    double apuesta_actual = lanzamientoplayer.apuestaminima;
    final _pref = PreferenciasUsuario();
    String _fotousargeneral =
        "https://images.freeimages.com/images/large-previews/4dc/free-casino-table-cloth-texture-1637741.jpg"; //solo en jugador

    var _color_backgroub = Colors.black;
    bool _ver_tx_estado = false;
    // startTimer(_contador_tiempo);

    if (lanzamientoplayer.uid != _pref.token) {
      //_fotousargeneral=lanzamientoplayer.foto;
      //1. recolectar dinero
      if (lanzamientoplayer.apuestaminima == 0) {
        //jugador aun no se ve
        _color_backgroub = Colors.red;
      }
      //2. turno de quien le toca
      if (lanzamientoplayer.turno != false) {
        //mostramos
        _color_backgroub = Colors.green;

        minut = 1;
        _ver_tx_estado = true;

        //startTimer(lanzamientoplayer, _mesadados_principal);
      }

      //3.
    }

    ///
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    //lo puse primero para llamarlo pero empezamos con widget 2
    ///
    /// solo nombre y fichas
    Widget widget3_datosjugador1 = Container(
      height: 40,
      width: 100,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 40, color: color_principal)),
          child: Container(
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(nombre,
                          textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              leadingDistribution:
                                  TextLeadingDistribution.proportional,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(fichas.toString(),
                          // textScaleFactor: 10,
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                  ],
                )),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3.0, //1 no mucho cambio
            offset: Offset(0, 5),
            spreadRadius: 0.9,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );

    Widget widget2_foto = Container(
      //alignment: Alignment.topCenter,
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: _color_backgroub,
            blurRadius: 5.0, //1
            offset: Offset(3, 5), //0,5
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),

      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(width: 1, color: color_principal)),
        child: Stack(
          children: <Widget>[
            //fondo

            //perfil
            Container(
              height: double.infinity,
              width: double.infinity,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.freeimages.com/images/large-previews/4dc/free-casino-table-cloth-texture-1637741.jpg"), // peliculas_list[index].getposterimage()
              ),
            ),
            //nombre y fichas
            Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    widget3_datosjugador1,
                  ],
                )),

            //eiinado por ahora
            Visibility(
              child: Container(
                padding: EdgeInsets.only(left: 30),
                alignment: Alignment.topCenter, //no
                // width: double.infinity,
                // color: Colors.white38,
                child: Row(
                  children: [
                    ClipRect(
                      child: Icon(Icons.casino),
                    ),
                    ClipRect(
                      child: Icon(Icons.casino),
                    ),
                  ],
                ),
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: true,
            ),
            //circulo de regalos

            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      "https://banner2.cleanpng.com/20180506/kce/kisspng-gift-computer-icons-santa-claus-5aef2ed5403e26.1458458615256245332631.jpg"),
                ),

                Spacer(),
                //aviso de tiempo
                Visibility(
                  child: Container(
                    // alignment: Alignment.centerRight,//no
                    // width: double.infinity,
                    color: Colors.yellow[50],
                    child: ClipRect(
                      child: util_texts_black2_agregattamano(
                          _contador_tiempo.toString(), 1),
                      //contador_minutos4, //me encanta pero no puedo reiniciarlo
                    ),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _ver_tx_estado,
                ),
              ],
            ),
            //mostrardados
            /* Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.bottomRight,
                child: widget4_dados),*/
          ],
        ),
      ),
    );

    return widget2_foto;
  }

  final _pref_user = new PreferenciasUsuario();
  int posicionenlista = 0; //turno
  Widget _4_jugadorprincipal(
      BuildContext context, String nombre, double fichas) {
    //verificamos cual es el nuestro

    bool _ver_tx_estado = false;

    var _color_backgroub = Colors.black;
    Lanzamientoplayer _lanzamientoplayer_playerp;
    for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
      if (_mesadados_principal.lanzamientoplayer[i].uid == _pref_user.token) {
        fichas = _mesadados_principal.lanzamientoplayer[i].fichasplayer;
        _lanzamientoplayer_playerp = _mesadados_principal.lanzamientoplayer[i];
        if (_lanzamientoplayer_playerp.apuestaminima == 0) {
          //jugador aun no se ve
          _color_backgroub = Colors.red;
        }
        //2. turno de quien le toca
        if (_lanzamientoplayer_playerp.turno != false) {
          //mostramos
          _color_backgroub = Colors.green;
          _ver_tx_estado = true;
          if (_lanzamientoplayer_playerp.apuestaminima == 0) {
            _mostrarapuesta = true;
            startTimer(_lanzamientoplayer_playerp, _mesadados_principal);
          }
        }
      }
    }

    Widget widget3_datosjugador1 = Container(
      height: 40,
      width: 100,
      child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 2, color: color_principal)),
          child: Container(
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(_pref_user.nombre,
                          // textScaleFactor: 10,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1,
                          style: TextStyle(
                              leadingDistribution: TextLeadingDistribution.even,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(fichas.toString(),
                          overflow: TextOverflow.ellipsis,
                          // textScaleFactor: 10,
                          style: TextStyle(
                              leadingDistribution: TextLeadingDistribution.even,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                  ],
                )),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            //borde de los textos
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.5,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );

    return Container(
      alignment: Alignment.bottomCenter,
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: _color_backgroub,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(width: 1, color: color_principal)),
        child: Stack(
          children: <Widget>[
            //perfil
            Container(
              height: double.infinity,
              width: double.infinity,
              child:
                  CircleAvatar(backgroundImage: NetworkImage(_pref_user.foto)),
            ),
            //nombre y fichas
            Container(
                padding: EdgeInsets.only(top: 90),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    widget3_datosjugador1,
                  ],
                )),

            //circulo de regalos
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      "https://banner2.cleanpng.com/20180506/kce/kisspng-gift-computer-icons-santa-claus-5aef2ed5403e26.1458458615256245332631.jpg"),
                ),
                Spacer(),
                Visibility(
                  child: Container(
                    // alignment: Alignment.centerRight,//no
                    // width: double.infinity,
                    color: Colors.red[100],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: util_texts_black2_agregattamano(
                          _contador_tiempo.toString(), 2),
                    ),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _ver_tx_estado,
                ),
              ],
            ),
            //mostrardados
            /* Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.bottomRight,
                child: widget4_dados),*/
          ],
        ),
      ),
    );
  }

  _5_botonesdame(BuildContext context) {
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    Widget _foldbtn = Container(
      height: 40,
      width: 110,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            child: Container(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Icon(Icons.cancel, color: Colors.red[300]),
                    Text(" "),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Fold",
                          textScaleFactor: 1.7,
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                  ],
                )),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );
    Widget _check2b = Container(
      height: 40,
      width: 110,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: color_principal)),
          child: GestureDetector(
            onTap: () {
              // _guardarfirebase(context);
            },
            child: Container(
              child: Container(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      Icon(Icons.add_task, color: Colors.green[300]),
                      Text(" "),
                      Container(
                        alignment: Alignment.center,
                        child: Text("Check",
                            textScaleFactor: 1.7,
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none)),
                      ),
                    ],
                  )),
            ),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );

    return Container(
      padding: EdgeInsets.only(top: _screensize.height * 0.8),
      //padding: EdgeInsets.only(top: double.),
      alignment: Alignment.bottomRight,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          _check2b,
          SizedBox(height: 5),
          //raisetn,
          SizedBox(height: 5),
          _foldbtn,
        ],
      ),
    );
  }

  Widget _6_crearslider_cash(BuildContext context) {
    var _lowerValue;
    var _upperValue;
    int apuesta = 100;
    //3
    Widget raisetn = Container(
      height: 40,
      width: 110,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            child: Container(
                //  alignment: Alignment.bottomRight,
                child: Row(
              children: [
                Icon(Icons.upload_rounded, color: Colors.yellow[700]),
                Text(" "),
                Container(
                  alignment: Alignment.center,
                  child: Text("Raised",
                      textScaleFactor: 1.7,
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none)),
                ),
              ],
            )),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );
//2.
    Widget _iconosapuesta = Container(
      color: Colors.white38,
      child: Column(
        children: <Widget>[
          Container(
            child: raisetn,
            padding: EdgeInsets.only(bottom: 10),
          ),
          ClipRRect(
            child: Icon(
              Icons.keyboard_arrow_up_sharp,
              color: Colors.red[900],
            ),
            // child: Icon(Icons.add_circle_rounded ),
          ),
          Text(
            apuesta.toString(),
            textScaleFactor: 2,
          ),
          ClipRRect(
              child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.red[900],
          )
              // child: Icon(Icons.add_circle_rounded ),
              )
        ],
      ),
    );
    //1
    Widget apuestas = Container(
      height: 150,
      width: 130,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            child: _iconosapuesta,
          )),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );

    return apuestas;
    // return Container(alignment: Alignment.bottomLeft, child: apostar);
  }

  _7_mesa_centro(BuildContext context) {
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    //dados
    Widget _dado1_mesa = Container(
      height: 80,
      width: 60,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            child: Container(
              child: ClipRRect(
                child: Expanded(
                    child: Image(image: AssetImage("assets/dado1_cara.png"))),
              ),
            ),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );

    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                _dado1_mesa,
                _dado1_mesa,
                _dado1_mesa,
              ],
            ),
            Container(
              //  alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 40),
              child: Row(
                children: <Widget>[
                  _dado1_mesa,
                  _dado1_mesa,
                ],
              ),
            ),
          ],
        ));
  }

  //simple y descartada  necesito controlar todo el jeugo aqui
  /* Future _iniciarpartida(
      BuildContext context, Buscarpartida partida_selec) async {
    print("iniciando juego dados");
    try {
      await iniciar_juego_(context, partida_selec);
    } catch (e) {}
    //print(object);
  }*/

//8 empezamos la partida  con buscar partida  y asignamos una global
//HASTA AHORA LA MEJOR MANERA O ALMENOS QUE HA FUNCIONADO .
  Future _buscarpartidav2(
      BuildContext context, Buscarpartida partidaasignada) async {
    final _pref_user = new PreferenciasUsuario();
    var busqueda1 = FirebaseFirestore.instance.collection('mesadados');
    await busqueda1
        .orderBy('timestamp', descending: false)
        //.where("partida", isEqualTo: partidaasignada.numero)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isEmpty) {
        //player 1 con datos reales el resto falsos
        var _jugador0 = Lanzamientoplayer(
            uid: partidaasignada.jugadoreson[0].uid,
            notifi: partidaasignada.jugadoreson[0].notifi,
            timesplayer: partidaasignada.jugadoreson[0].timesplayer,
            times_int: timestamp_obtenercodigo_int(),
            nombreplayer: partidaasignada.jugadoreson[0].nombre,
            fichasplayer: partidaasignada.jugadoreson[0].fichasplayerson,
            onplayer: false,
            turno: true,
            apuestaminima: 0,
            dado1: 0,
            dado2: 0);
        var _jugador1 = Lanzamientoplayer(
            times_int: timestamp_obtenercodigo_int(),
            uid: partidaasignada.jugadoreson[1].uid,
            notifi: partidaasignada.jugadoreson[1].notifi,
            timesplayer: partidaasignada.jugadoreson[1].timesplayer,
            nombreplayer: partidaasignada.jugadoreson[1].nombre,
            fichasplayer: partidaasignada.jugadoreson[1].fichasplayerson,
            onplayer: false,
            turno: false,
            apuestaminima: 0,
            dado1: 0,
            dado2: 0);
        var _jugador2 = Lanzamientoplayer(
            times_int: timestamp_obtenercodigo_int(),
            uid: partidaasignada.jugadoreson[2].uid,
            notifi: partidaasignada.jugadoreson[2].notifi,
            timesplayer: partidaasignada.jugadoreson[2].timesplayer,
            nombreplayer: partidaasignada.jugadoreson[2].nombre,
            fichasplayer: partidaasignada.jugadoreson[2].fichasplayerson,
            onplayer: false,
            turno: false,
            apuestaminima: 0,
            dado1: 0,
            dado2: 0);
        var _jugador3 = Lanzamientoplayer(
            times_int: timestamp_obtenercodigo_int(),
            uid: partidaasignada.jugadoreson[3].uid,
            notifi: partidaasignada.jugadoreson[3].notifi,
            timesplayer: partidaasignada.jugadoreson[3].timesplayer,
            nombreplayer: partidaasignada.jugadoreson[3].nombre,
            fichasplayer: partidaasignada.jugadoreson[3].fichasplayerson,
            onplayer: false,
            turno: false,
            apuestaminima: 0,
            dado1: 0,
            dado2: 0);
        var _jugador4 = Lanzamientoplayer(
            times_int: timestamp_obtenercodigo_int(),
            uid: partidaasignada.jugadoreson[4].uid,
            notifi: partidaasignada.jugadoreson[4].notifi,
            timesplayer: partidaasignada.jugadoreson[4].timesplayer,
            nombreplayer: partidaasignada.jugadoreson[4].nombre,
            fichasplayer: partidaasignada.jugadoreson[4].fichasplayerson,
            onplayer: false,
            turno: false,
            apuestaminima: 0,
            dado1: 0,
            dado2: 0);
        print("carpeta vacia");
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

        _buscarpartidav2(context, partidaasignada);

        // busqueda1.add()
      } else {
        // _buscarpartidav3(context, partidaasignada);
        // 1. ya creada la apartida debemos obtenerla y mostrar los usuario - listo
        querySnapshot.docs.forEach((doc) {
          Mesadados _snap_mesa = Mesadados.fromdocument(doc);
          print("si existe la partida !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          print(_snap_mesa);

          var snapp = Mesadados.fromJson(_snap_mesa.toJson());

          setState(() {
            //parece que obtube la partida y control del json
            _mesadados_principal = _snap_mesa;

            //funciona pero me gustaria probar con stream builder
          });
          //2. obtener lista de jugadores on , no me funciono dle todo

          int usuarios = _mesadados_principal.lanzamientoplayer.length;
          for (var i = 0; i < usuarios; i++) {
            var playeron = _mesadados_principal.lanzamientoplayer[i];
            if (playeron.onplayer != false) {
              if (playeron.uid != _pref_user.token) {
                _listaplayers_on.add(playeron);
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

//deberia usar este methodo pero no funciono
  _buscarpartidav3(BuildContext context, Buscarpartida partidaasignada) async {
    var busqueda1 =
        FirebaseFirestore.instance.collection('mesadados').snapshots();
    StreamBuilder(
      stream: busqueda1,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var data_snap = Mesadados.map(snapshot.data);

        print(data_snap);
        // var mesasnap=Mesadados.fromdocument(snapshot));
        // _mesadados_principal=
        return Container();
      },
    );
  }
  // SI LA ORIENTACION horizontal

}
