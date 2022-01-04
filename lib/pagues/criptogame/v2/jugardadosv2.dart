import 'dart:async';
import 'Dart:math';

//import 'package:audioplayer/audioplayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/pagues/criptogame/dados/provider_dados_dagme.dart';
import 'package:criptodadosweb/pagues/models/juegodados/model_mesadados.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:criptodadosweb/utils/utils.dart';
import 'package:criptodadosweb/utils/utils_textos.dart';
import 'package:criptodadosweb/widgets/dados%20animation/animaciones.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

//base vacia para su cambios
String _mesa = "";
var _mesadados_principal = Mesadados(
    partida: "1",
    tablero: "1",
    timestamp: "timer",
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
String jugadorenturno_name = "";

class Jugardadosv22 extends StatefulWidget {
  Jugardadosv22(this.mesa, this.mesawidget, {Key? key}) : super(key: key);
  //inicializar variables en clase
  String mesa;
  Mesadados mesawidget;
  @override
  _Jugardadosv22State createState() => _Jugardadosv22State();
}

//final _pref_user = new PreferenciasUsuario();
int posicionenlista = 0; //turno
int _contador_tiempo = 1000;
int _contador_mostrardados = 200;
bool _mostrarapuesta = false;
int totalplayers_on = 0;
//
bool _verdado_showdados = false;
var foto_c = "";
var nombre_c = "";
var _uid = "";

class _Jugardadosv22State extends State<Jugardadosv22> {
  //2 jugadores
  //6 dados
  //aun no primero vamos a provar como pagar
  //uid1 uid2
  Color color_principal = const Color.fromRGBO(150, 250, 200, 0.2);
  //slide
  double _valorslider = 100.0;
  bool _bloquearcheck = false;
  String _frase_juego = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //  _mesa = widget;
    // _mesadirestorev2();
    _mesaprincipal_firestore(widget.mesa);
    _nombreusuarioenturno();

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
            /* appBar: AppBar(
              title: Text("ORIENTACIÓN HORIZONTAL"),
              backgroundColor: Colors.red,
            ),*/
            body: _00_vertical_normal(context),
            /*
             new Container(
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
            ),*/
          );
        }
      }),
    );
  }

  // SI LA ORIENTACION ESTA EN VERTICAL
  late Timer _timer = Timer(const Duration(), () {});
  int minut = 1;

  //jugador 1
  void _startTimer(
      Lanzamientoplayer lanzamientoplayer, Mesadados mesadados_principal) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_contador_tiempo == 0) {
          if (lanzamientoplayer.uid == _uid) {
            // _mostrarapuesta = false; //quitamos el alerta de unirse
            //probando vieja manera
            //player principal
            //no mejor pasar un fold o el controlador nuevo
            // await player_no_aposto(lanzamientoplayer, mesadados_principal);
            //PARECE FUNCIONAR player_play_dados
            /*  player_play_dados(
                lanzamientoplayer,
                _mesadados_principal,
                2, //fold
                _mesadados_principal.apuestabase);*/
          } else {
            //otro jugador no jugo
            // await jugadores_nojugo(lanzamientoplayer, mesadados_principal);
          }
          setState(() {
            timer.cancel();
            // _contador_tiempo = 1000;

            //

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

  Widget _00_vertical_normal(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    Widget pantallanormal = Container(
      child: Stack(
        children: <Widget>[
          _1fondo_pantalla(context),
          _2mesa_tablero(context),
          _002_salirdemesa(context),
          _3_lista_jugadores(context),
          //4_principal player
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
            padding: const EdgeInsets.only(right: 20),
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
                top: _screensize.height * 0.05, left: _screensize.width * 0.25),
            alignment: Alignment.center,
            child: _7_mesa_centro(context),
          ),
          Container(
            padding: EdgeInsets.only(
                top: _screensize.height * 0.1, left: _screensize.width * 0.40),
            alignment: Alignment.center,
            //  alignment: Alignment.center,
            child: _8_dadosanimacion(),
          )

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
          padding: const EdgeInsets.only(top: 10), //pading superos
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
                          child: const Image(
                              image: const AssetImage(
                                  "assets/01_fondo_gris_juegodados.jpg"),
                              fit: BoxFit.cover)
                          /* FadeInImage(
                          image: NetworkImage("https://wallpapercave.com/wp/tOhBZQr.jpg"), // peliculas_list[index].getposterimage()
                          placeholder: AssetImage('assets/01_fondo_gris_juegodados.jpg'),
                          fit: BoxFit
                              .cover, //reparo el error del controno medio ciruclar
                        */

                          ),
                      Container(
                        height: 50,
                        alignment: Alignment.topCenter,
                        color: Colors.white38,
                        child: ClipRRect(
                          //clip reect para poner el border y dento ponemos la imagen
                          borderRadius: BorderRadius.circular(20),
                          //PRIMER TEXTO PRINCIPAL
                          child: util_texts_white_2_agregattamano(
                              jugadorenturno_name, 2),
                          /*Text(
                            jugadorenturno_name,
                            
                            // Text(_mesadados_principal.partida.toString(),
                            //textScaleFactor: 24,
                            textScaleFactor: 2.5,

                            overflow: TextOverflow
                                .ellipsis, //cuando el texto no cabe pone puntitos
                            style: Theme.of(context).textTheme.caption,)*/
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
          padding: const EdgeInsets.fromLTRB(40, 50, 40, 100), //pading superos

          /// _screÑensize.height * 0.5, //la mitad del dispitivo

          child: Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
                side: const BorderSide(width: 7, color: Colors.white38)),
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

                        child: const Image(
                            image: AssetImage("assets/1fondoverde.png"),
                            fit: BoxFit.cover),
                      )
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

  bool salir = false;
  Widget _002_salirdemesa(BuildContext context) {
    //el usuario que sale pone todo off
    double monedas_departidaporjugar = 0;

    return Container(
        //  height: 100,
        child: Column(
      children: [
        IconButton(
          icon: const Icon(Icons.home, color: Colors.black, size: 50),
          onPressed: () {
            var remplzasaruser = Lanzamientoplayer(
                uid: "uid",
                notifi: "notifi",
                timesplayer: "timesplayer",
                nombreplayer: "nombreplayer",
                onplayer: false,
                turno: false,
                dado1: 0,
                dado2: 0,
                fichasplayer: 0,
                apuestaminima: 0,
                times_int: 0);
            //salir d ela partrida y ya el dinero se cobra solo cuando gana
            for (var i = 0;
                i < _mesadados_principal.lanzamientoplayer.length;
                i++) {
              if (_mesadados_principal.lanzamientoplayer[i].onplayer != false &&
                  _mesadados_principal.lanzamientoplayer[i].uid == _uid) {
                monedas_departidaporjugar =
                    _mesadados_principal.lanzamientoplayer[i].fichasplayer;
                _mesadados_principal.lanzamientoplayer[i] = remplzasaruser;

                if (salir != true) {
                  salir = false;
                  salirmesa1(
                      _mesadados_principal, context, monedas_departidaporjugar);
                }
              }
            }
          },
        ),
        util_texts_white_2_agregattamano(" Exit", 1),
      ],
    ));
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
        padding: const EdgeInsets.only(top: 150), //200

        child: Column(
          children: [
            _jugador1(context, _mesadados_principal.lanzamientoplayer[0]),
            util_texts(_mesadados_principal.lanzamientoplayer[0].apuestaminima
                .toString()),
            Visibility(
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.bottomCenter, //no
                // width: double.infinity,
                // color: Colors.white38,
                child: Row(
                  children: [
                    ClipRect(
                      child: Stack(
                        children: [
                          const Icon(Icons.casino),
                          util_texts_white_2_agregattamano("0", 1),
                        ],
                      ),
                    ),
                    const ClipRect(
                      child: const Icon(Icons.casino),
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
        padding: const EdgeInsets.only(top: 400),
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
        padding: const EdgeInsets.only(top: 200),

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
        padding: const EdgeInsets.only(top: 400),
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
              side: const BorderSide(width: 7, color: Colors.white38)),
          child: Container(
            //padding: EdgeInsets.only(bottom: 200),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 200),

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
          padding: const EdgeInsets.only(top: 400),
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
          padding: const EdgeInsets.only(top: 200),

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
          padding: const EdgeInsets.only(top: 400),
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

                      padding: const EdgeInsets.all(15),
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
                child: Stack(
                  children: [
                    const Icon(Icons.casino),
                    util_texts_white_2_agregattamano("0", 1),
                  ],
                ),
              ),
              const ClipRect(
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

                      padding: const EdgeInsets.all(15),
                      child: Stack(
                        children: <Widget>[
                          //enemigo 1 a la  izquierda arriba
                          Container(
                            //padding: EdgeInsets.only(bottom: 200),
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(top: _screensize.height * 0.2),

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
                            padding: EdgeInsets.only(
                                top: _screensize.height * 0.5), //400
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
                            padding:
                                EdgeInsets.only(top: _screensize.height * 0.2),

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
                            padding:
                                EdgeInsets.only(top: _screensize.height * 0.5),
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
    var d1_1 = "";
    var d2_1 = "";
    if (lanzamientoplayer.dado2 != 0 && lanzamientoplayer.dado2 != 0) {
      d1_1 = lanzamientoplayer.dado1.toString();
      d2_1 = lanzamientoplayer.dado2.toString();
    }

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

        _ver_tx_estado = true;

        _startTimer(lanzamientoplayer, _mesadados_principal);
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
                          style: const TextStyle(
                              leadingDistribution:
                                  TextLeadingDistribution.proportional,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(fichas.toString(),
                          // textScaleFactor: 10,
                          style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                  ],
                )),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
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
            offset: const Offset(3, 5), //0,5
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
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.freeimages.com/images/large-previews/4dc/free-casino-table-cloth-texture-1637741.jpg"), // peliculas_list[index].getposterimage()
              ),
            ),
            //nombre y fichas
            Container(
                padding: const EdgeInsets.only(top: 50),
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    widget3_datosjugador1,
                  ],
                )),

            //eiinado por ahora
            Visibility(
              child: Container(
                padding: const EdgeInsets.only(left: 30),
                alignment: Alignment.topCenter, //no
                // width: double.infinity,
                // color: Colors.white38,
                child: Row(
                  children: [
                    ClipRect(
                      child: Stack(
                        children: [
                          const Icon(Icons.casino),
                          util_texts_white_2_agregattamano(d1_1, 1),
                        ],
                      ),
                    ),
                    ClipRect(
                      child: Stack(
                        children: [
                          const Icon(Icons.casino),
                          util_texts_white_2_agregattamano(d2_1, 1),
                        ],
                      ),
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
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      "https://banner2.cleanpng.com/20180506/kce/kisspng-gift-computer-icons-santa-claus-5aef2ed5403e26.1458458615256245332631.jpg"),
                ),

                const Spacer(),
                //aviso de tiempo
                Visibility(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
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

//
  Widget _4_jugadorprincipal(
      BuildContext context, String nombre, double fichas) {
    //verificamos cual es el nuestro
    _cargarpreferencias(); //web
    /* if (fo != "") {
      foto_c = _pref_user.foto;
      print("si ahi foto ");
    }
    if (_pref_user.nombre != "") {
      nombre_c = _pref_user.nombre;
      print(nombre_c);
    }*/

    bool _ver_tx_estado = false;

    var _color_backgroub = Colors.black;
    Lanzamientoplayer _lanzamientoplayer_playerp;
    for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
      if (_mesadados_principal.lanzamientoplayer[i].uid ==
          Icons.query_builder_outlined) {
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
          /*   if (_lanzamientoplayer_playerp.apuestaminima == 0 &&
              totalplayers_on > 1) {
            _mostrarapuesta = true;
            _startTimer(_lanzamientoplayer_playerp, _mesadados_principal);
          }*/
        }
      }
    }

    Widget widget3_datosjugador1 = Container(
      height: 70,
      width: 150,
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
                      child: Text(nombre_c,
                          // textScaleFactor: 10,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1,
                          style: const TextStyle(
                              leadingDistribution: TextLeadingDistribution.even,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(fichas.toString(),
                          overflow: TextOverflow.ellipsis,
                          // textScaleFactor: 10,
                          style: const TextStyle(
                              leadingDistribution: TextLeadingDistribution.even,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    ),
                  ],
                )),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
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
            offset: const Offset(0, 5),
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
              child: CircleAvatar(backgroundImage: NetworkImage(foto_c)),
            ),
            //nombre y fichas
            Container(
                padding: const EdgeInsets.only(top: 90),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    widget3_datosjugador1,
                  ],
                )),

            //circulo de regalos
            Row(
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      "https://banner2.cleanpng.com/20180506/kce/kisspng-gift-computer-icons-santa-claus-5aef2ed5403e26.1458458615256245332631.jpg"),
                ),
                const Spacer(),
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

  // AudioPlayer audioPlugin = AudioPlayer();
  // AudioPlayer audioPlayer = new AudioPlayer();
//  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  playLocalyes() async {
    print("playsonido");

    /*  AudioCache audioCache;
       audioCache = new AudioCache(fixedPlayer: advancedPlayer);
     
    audioCache.play('audio.mp3'*/
    //--------
    // final file =
    //   new File('${(await getTemporaryDirectory()).path}/assets/mp3/yes.mp3');
    //await file.writeAsBytes((await loadAsset()).buffer.asUint8List());
    // final result = await audioPlayer.play(file.path, isLocal: true);
    //--------------
    //inguna funcion
    //var result = await audioPlayer.play("yes.mp3", isLocal: true);
    //var result3 = await audioPlayer.seek(Duration(milliseconds: 1200));

    // var result2 = await audioPlayer.play("assets/mp3/yes.mp3", isLocal: true);
    // var result3 = await audioPlayer.play("assets/yes.mp3", isLocal: true);

    // AudioPlayer audioPlayer = new AudioPlayer();
    // result = await audioPlayer.play(localPath, isLocal: true);
  }

  _5_botonesdame(BuildContext context) {
    bool _ver_tx_estado = false;

    var fichas;
    var _color_backgroub = Colors.black;
    Lanzamientoplayer lanzamientoplayer_btns = Lanzamientoplayer(
        uid: "uid",
        notifi: "notifi",
        timesplayer: " timesplayer",
        times_int: 0,
        nombreplayer: " nombreplayer",
        onplayer: false,
        turno: false,
        dado1: 0,
        dado2: 0,
        fichasplayer: 0,
        apuestaminima: 100);
    for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
      if (_mesadados_principal.lanzamientoplayer[i].uid == _uid) {
        _mesadados_principal.lanzamientoplayer[i].fichasplayer;
        lanzamientoplayer_btns = _mesadados_principal.lanzamientoplayer[i];
        if (lanzamientoplayer_btns.apuestaminima == 0) {
          //jugador aun no se ve
          _color_backgroub = Colors.red;
        }
        //2. turno de quien le toca
        if (lanzamientoplayer_btns.turno != false) {
          //mostramos
          _color_backgroub = Colors.green;
          _ver_tx_estado = true;
          if (totalplayers_on < 1) {
            _mostrarapuesta = true;
            _startTimer(lanzamientoplayer_btns, _mesadados_principal);
          }
        }
      }
    }
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla

    ////botones fold no ir
    bool _flag = true; //btn
    Widget _foldbtn = Container(
      height: 40,
      width: 120,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            child: Container(
                width: double.infinity,
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _flag
                        ? Colors.red[50]
                        : Colors.teal, // This is what you need!
                  ),
                  onPressed: () {
                    if (_mostrarapuesta != false) {
                      print("fold");
                      //no te alcanza el dinero
                      //misfichas<apuestatotal
                      // int apuesta = _mesadados_principal.apuestabase;
                      //no tienes suficiente dinero listo
                      //fold

                      if (lanzamientoplayer_btns.fichasplayer <
                          _mesadados_principal.apuestabase) {
                        show_buttonsheep_util(
                            context, "sorry but , yours cash over ");
                      }
                      if (lanzamientoplayer_btns.apuestaminima == 0) {
                        print("apuesta primera vez");
                        //funciona ya que lo saca
                        player_play_dados(
                            lanzamientoplayer_btns,
                            _mesadados_principal,
                            2, //fold
                            _mesadados_principal.apuestabase);
                      }
                      //fold=2

                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red[300]),
                      const Text(" "),
                      Container(
                        alignment: Alignment.center,
                        child: const Text("Fold",
                            textScaleFactor: 1.7,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none)),
                      ),
                    ],
                  ),
                )),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );
    //AUMENTAR RAISET
    //check
    Widget _check2b = Container(
      height: 40,
      width: 120,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            // alignment: Alignment.bottomRight,
            child: Flexible(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: _flag
                    ? Colors.green[50]
                    : Colors.teal, // This is what you need!
              ),
              onPressed: () async {
                //nada de abajo ha funciondo sin causar daños con otra dpendencia
                //hacer sonar
                // var audioplayer = AudioPlayerState;
                // var audioplayer1 = AudioPlayer();
                /* final audio = AudioCache();
                // behavior_subject_mixin: null
                audio.play("yes.mp3");
                print("object");
                AudioCache player = new AudioCache();
                const alarmAudioPath = "yes.mp3";
                player.play(alarmAudioPath);*/
                // audioplayer.play(url)
                // await audioPlayer.setUrl('clicking.mp3');
                // await player.setAsset('assetsflutter run --no-sound-null-safety/mp3/yes.mp3');
                // await audioplayer.play('yes.mp3', isLocal: true);
                // await audioplayer.play('assets/mp3/yes.mp3', isLocal: true);
                //await player.play('yes.mp3', isLocal: true);
                /*   Future<ByteData> loadAsset() async {
                  return await rootBundle.load('sounds/music.mp3');
                }

// FIXME: This code is not working.
                final file =
                    new File('${(await getTemporaryDirectory()).path}/yes.mp3');
                await file
                    .writeAsBytes((await loadAsset()).buffer.asUint8List());
                final result = await player.play(file.path, isLocal: true);
*/
                if (lanzamientoplayer_btns.turno != false &&
                    totalplayers_on > 1) {
                  print("Check");
                  //no te alcanza el dinero
                  //misfichas<apuestatotal
                  // int apuesta = _mesadados_principal.apuestabase;
                  //no tienes suficiente dinero listo
                  //CHECK

                  if (lanzamientoplayer_btns.fichasplayer <
                      _mesadados_principal.apuestabase) {
                    show_buttonsheep_util(
                        context, "sorry but , yours cash over ");
                  }
                  if (lanzamientoplayer_btns.apuestaminima == 0) {
                    print("apuesta primera vez");
                    //funciona ya que lo saca
                    player_play_dados(
                        lanzamientoplayer_btns,
                        _mesadados_principal,
                        1, //CHECK
                        _mesadados_principal.apuestabase);
                  }
                  if (lanzamientoplayer_btns.apuestaminima > 10) {
                    print("continuar sin aumentar apuesta");
                    //funciona ya que lo saca
                    player_play_dados(
                        lanzamientoplayer_btns,
                        _mesadados_principal,
                        1, //CHECK
                        _mesadados_principal.apuestabase);
                  }
                  //fold=2

                }
                if (totalplayers_on < 2) {
                  mostrardialogbuttonshet(context, "esperando jugadores");
                }
              },
              child: Row(
                children: [
                  Icon(Icons.check, color: Colors.green[900]),
                  const Text(" "),
                  Container(
                    alignment: Alignment.center,
                    child: const Text("Yes",
                        textScaleFactor: 1.7,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none)),
                  ),
                ],
              ),
            )),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
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
          const SizedBox(height: 5),
          _check2b,
          const SizedBox(height: 5),
          //raisetn,
          const SizedBox(height: 5),
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
                const Text(" "),
                Container(
                  alignment: Alignment.center,
                  child: const Text("Raised",
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
          const BoxShadow(
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
            padding: const EdgeInsets.only(bottom: 10),
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
          const BoxShadow(
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

  _dado1_mesa(int _d1_playerdado) {
    String dadoselec1 = "assets/dado1_cara.png";
    String d1 = "assets/dado1_anim.gif";
    String d2 = "assets/dado2_anim.gif";
    String d3 = "assets/dado3_anim.gif";
    String d4 = "assets/dado4_anim.gif";
    String d5 = "assets/dado5_anim.gif";
    String d6 = "assets/dado6_anim.gif";
    if (_d1_playerdado == 1) {
      dadoselec1 = d1;
    }
    if (_d1_playerdado == 2) {
      dadoselec1 = d2;
    }
    if (_d1_playerdado == 3) {
      dadoselec1 = d3;
    }
    if (_d1_playerdado == 4) {
      dadoselec1 = d4;
    }
    if (_d1_playerdado == 5) {
      dadoselec1 = d5;
    }
    if (_d1_playerdado == 6) {
      dadoselec1 = d6;
    }
    return Container(
      height: 60,
      width: 60,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            child: Container(
              child: ClipRRect(
                child: Expanded(child: Image(image: AssetImage(dadoselec1))),
              ),
            ),
          )),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

//  bool _ver_invisible = false;
  _7_mesa_centro(BuildContext context) {
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    //
    // bool _ver_invisible = false;
    bool _iniciarpartida = false;

    bool _ver_invisible = false;

    double one = _mesadados_principal.apuestafinal;
    List<Lanzamientoplayer> _jugadoresaevaluar = []; //3 dados
    List<Lanzamientoplayer> _lanzamientoplayer1 = []; //3 dados
    List<Lanzamientoplayer> _lanzamientoplayer2 = []; //4 dados
    List<Lanzamientoplayer> _lanzamientoplayer3 = []; //4 dados
    List<Lanzamientoplayer> _lanzamientoplayer4 = []; //un par o casi nada
    List<Lanzamientoplayer> _lanzamientoplayer5 = []; //nadie gana
    List<Lanzamientoplayer> _lanzamientoplayer_winnershow =
        []; //para mostrar quienes ganan

    int _sumatotal = 0;
    //7.0 no hay nadie ingresado pongamos una alerta
    List<Lanzamientoplayer> _lanzamientoplayer3_turno_on = []; //estado on

    for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
      if (_mesadados_principal.lanzamientoplayer[i].turno != false) {
        _lanzamientoplayer3_turno_on
            .add(_mesadados_principal.lanzamientoplayer[i]);
      }
    }
    if (_lanzamientoplayer3_turno_on.length == 0) {
      _iniciarpartida = true;
    }

    //7.1 dadsos primera ronda
    if (totalplayers_on > 1 &&
        _mesadados_principal.d1 != 0 &&
        _mesadados_principal.d2 != 0 &&
        _mesadados_principal.d3 != 0 &&
        _mesadados_principal.d4 == 0 &&
        _mesadados_principal.d5 == 0) {
      //1.1 buscando ganador entre todos los jugadores quienes ya apostaron y lanzaron dados
      for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
        if (_mesadados_principal.lanzamientoplayer[i].onplayer != false &&
            _mesadados_principal.lanzamientoplayer[i].dado1 != 0 &&
            _mesadados_principal.lanzamientoplayer[i].dado2 != 0) {
          //1.2 jugadores de primera ronda que han jugado

          _sumatotal = _mesadados_principal.lanzamientoplayer[i].dado1 +
              _mesadados_principal.lanzamientoplayer[i].dado2 +
              _mesadados_principal.d1 +
              _mesadados_principal.d2 +
              _mesadados_principal.d3;
          //buscamos los ganadores
          if (_sumatotal == 21) {
            //lista de ganadores :
            _lanzamientoplayer1.add(_mesadados_principal.lanzamientoplayer[i]);
            //ganadores y se reparten el dienro
            //se acabo el ciclo y hay una lista de jugadores con 21
            _ver_invisible = true;

            //muestra un nombre si hay un ganador
            //  _frase_juego =_mesadados_principal.lanzamientoplayer[i].nombreplayer;

            if (_lanzamientoplayer1.length == 1) {
              //
              _frase_juego = _frase_juego =
                  _mesadados_principal.lanzamientoplayer[i].nombreplayer;
              _71_repartirdireno(one, _lanzamientoplayer1, "21 3 dados");
            }
            if (_lanzamientoplayer1.length > 1) {
              //
              _71_repartirdireno(one, _lanzamientoplayer1, "21 3 dados");
            }
          }
          ////////////////////
        }
      }

      //1.2 si el numero
      //jugadores qeu han lanzado y jugadres on
      //if(_lanzamientoplayer1.length<totalplayers_on){}

    }
    //7.2 con 5 ddos //aqui cargo las condicionaels del juego
    if (totalplayers_on > 1 &&
        _mesadados_principal.d1 != 0 &&
        _mesadados_principal.d2 != 0 &&
        _mesadados_principal.d3 != 0 &&
        _mesadados_principal.d4 != 0 &&
        _mesadados_principal.d5 != 0) {
      List<List<int>> _lista_delista = [];

      //1.1 buscando ganador entre todos los jugadores quienes ya apostaron y lanzaron dados
      for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
        if (_mesadados_principal.lanzamientoplayer[i].onplayer != false &&
            _mesadados_principal.lanzamientoplayer[i].dado1 != 0 &&
            _mesadados_principal.lanzamientoplayer[i].dado2 != 0) {
          _jugadoresaevaluar.add(_mesadados_principal.lanzamientoplayer[i]);
          //1.2 jugadores de primera ronda que han jugado

        }
      }
      //1.2entre los que estan on obtenemos a los ganadores
      for (var i = 0; i < _jugadoresaevaluar.length; i++) {
        if (_jugadoresaevaluar[i].onplayer != false &&
            _jugadoresaevaluar[i].dado1 != 0 &&
            _jugadoresaevaluar[i].dado2 != 0) {
          //1.2 jugadores de primera ronda que han jugado

          _sumatotal = _jugadoresaevaluar[i].dado1 +
              _jugadoresaevaluar[i].dado2 +
              _mesadados_principal.d1 +
              _mesadados_principal.d2 +
              _mesadados_principal.d3 +
              _mesadados_principal.d4 +
              _mesadados_principal.d5;
          //buscamos los ganadores
          //manos ganadoras
          //7 dados
          //2,2,2,2
          //1234567

          List<int> _listadados = [];
          _listadados.add(_mesadados_principal.d1);
          _listadados.add(_mesadados_principal.d2);
          _listadados.add(_mesadados_principal.d3);
          _listadados.add(_mesadados_principal.d4);
          _listadados.add(_mesadados_principal.d5);
          _listadados.add(_mesadados_principal.lanzamientoplayer[i].dado1);
          _listadados.add(_mesadados_principal.lanzamientoplayer[i].dado2);

          print("-------2------");
          //3 tercera forma de ganar quien tiene mas dados repetidos
          // var a_p = _listadados.where((item) => item == 1).toList(); ////
          var a1 = _listadados.where((item) => item == 1).toList().length; //1
          var a2 = _listadados.where((item) => item == 2).toList().length; //0
          var a3 = _listadados.where((item) => item == 3).toList().length; //2
          var a4 = _listadados.where((item) => item == 4).toList().length; //1
          var a5 = _listadados.where((item) => item == 5).toList().length; //3
          var a6 = _listadados.where((item) => item == 6).toList().length; //0

          var midado1 = _mesadados_principal.lanzamientoplayer[i].dado1;
          var midado2 = _mesadados_principal.lanzamientoplayer[i].dado2;
          List<int> _lista_orden_vaores = [a1, a2, a3, a4, a5, a6];
          // print(a_p); //5,5,5
          // print(a_p.length); //3  ya que se repite el 5
          //numero de veces que se repiten los numeros
          //1 ,2,3,4,5,6
          //[2, 0, 1, 1, 3, 0] player 1 se repite mas el 1
          //[1, 0, 2, 1, 3, 0] player 2 se repite mas el 0
          //  print([1,2,8,6].reduce(max)); // 8
          // print([1,2,8,6].reduce(min)); // 1
          //nota : obtenerl el numero que mas se repite en cada lista y comparar los resultados
          var full4 =
              _lista_orden_vaores.where((item) => item == 4).toList().length;
          var trio = _lista_orden_vaores
              .where((item) => item == 3)
              .toList()
              .length; //3
          var duo = _lista_orden_vaores
              .where((item) => item == 2)
              .toList()
              .length; //0
          var unidad =
              _lista_orden_vaores.where((item) => item == 1).toList().length;

          int posicion_mas_repetido = _lista_orden_vaores
              .reduce(max); //ej 3 y tiene 5,5,5 un trio  //import 'Dart:math';
          print(_lista_orden_vaores);
          //
          int dado_mas_repetido = _listadados.reduce(max); //umero mayor
          //  print("dado mas repetido: " + dado_mas_repetido.toString());
          _lista_delista.add(_lista_orden_vaores);
          //

          //. numeros repetidos------ minimo 3 veces
          //2.tiene almenos 4 dados iguales rj
          //1 winner 1 forma con 21------------------
          //BREAK ELIMINA UN ERROR PERO NO ME DEJA EXAMINAR MBIEN LA LISTA

          if (_sumatotal == 21) {
            //lista de ganadores :
            _lanzamientoplayer2.add(_jugadoresaevaluar[i]);
            //ganadores y se reparten el dienro
            //se acabo el ciclo y hay una lista de jugadores con 21

          }
          //2. 4 iguales [4, 0, 2, 0, 1, 0]? no lo selecciona
          else if (full4 != 0 || trio > 1) {
            _lanzamientoplayer1.add(_jugadoresaevaluar[i]);
            for (var m = 0; m < _lista_orden_vaores.length; m++) {
              //
              if (_lista_orden_vaores[m] == posicion_mas_repetido) {
                //ej 3 dados
                print("numero mas repetido: " + (m + 1).toString());
              }
            }
          }
          //2 pares un trio || 3 pares un trio
          //[2, 0, 1, 1, 3, 0]
          else if (duo >= 2 && trio >= 1) {
            print("dos dados y un trio");
            _lanzamientoplayer3.add(_jugadoresaevaluar[i]);
            //ganadores y se reparten el dienro
            //se acabo el ciclo y hay una lista de jugadores con 21

          } else if (duo == 1 && trio == 1) {
            print("un duo y un trio");
            _lanzamientoplayer4.add(_jugadoresaevaluar[i]);
            //ganadores y se reparten el dienro
            //se acabo el ciclo y hay una lista de jugadores con 21

          }
          //como lo configure?
          else if (duo <= 2 && trio < 1 && full4 == 0) {
            print("nada de mano");
            //la casa gana
            _lanzamientoplayer5.add(_jugadoresaevaluar[i]);
            //  _frase_juego =_mesadados_principal.lanzamientoplayer[i].nombreplayer;

          }
          //final ?

          //manos ganadoras
          //7 dados
          //2,2,2,2
          //1234567

          ////////////////////
        }
      }

      //1.3no se si sirva pero lo dejare pos inse em ocurre algo
      print("buscando ganadores!!");
      print("21 : " + _lanzamientoplayer2.length.toString());
      print("4 igaules: " + _lanzamientoplayer1.length.toString());
      print("mas pares y trios: " + _lanzamientoplayer3.length.toString());
      print("1 par 1 trio: " + _lanzamientoplayer4.length.toString());
      print("all lost: " + _lanzamientoplayer5.length.toString());
      //1. los que ganan con 21
      if (_lanzamientoplayer2.length > 0 &&
          _lanzamientoplayer_winnershow.length < 1) {
        print("mano ganadora _lanzamientoplayer2. ");
        //  _lanzamientoplayer_winnershow = _lanzamientoplayer2;
        // _ver_invisible = true;

        /* _frase_juego = "Results in " + _contador_mostrardados.toString();
        const oneSec = const Duration(seconds: 1);
        _timer = Timer.periodic(
          oneSec,
          (Timer timer) {
            if (_contador_mostrardados <= 0) {
              print("0");
            }
            if (_contador_mostrardados != 0) {
              setState(() {
                _contador_mostrardados--;
              });
            }
          },
        );*/
        _lanzamientoplayer_winnershow = _lanzamientoplayer2;

        //no funcioan del todo el timmer
        if (_lanzamientoplayer2.length == 1) {
          //
          //  _frase_juego =_mesadados_principal.lanzamientoplayer[i].nombreplayer;
          _ver_invisible = true;
          _71_repartirdireno(one, _lanzamientoplayer2, " 21-1");

          // break;
        } else if (_lanzamientoplayer2.length > 1) {
          //
          _ver_invisible = true;

          _71_repartirdireno(one, _lanzamientoplayer2, " 21-2");

          // break;

        }
      }
      //2. 4 dados o mas iguales
      else if (_lanzamientoplayer1.length > 0) {
        print("winnes +4 dados iguales");
        _lanzamientoplayer_winnershow = _lanzamientoplayer1;
        //no
        //_conteomostrarwinner(_lanzamientoplayer1, 2);
        if (_lanzamientoplayer1.length == 1) {
          //
          _ver_invisible = true;

          _71_repartirdireno(one, _lanzamientoplayer1, "+ 4 dados iguales");
        }
        if (_lanzamientoplayer1.length > 1) {
          //
          _ver_invisible = true;

          _71_repartirdireno(one, _lanzamientoplayer1, " + 4 dados iguales2");
        }
      }
      //3.  mas de  trio y almenos un par  duo == 2 && trio >= 1 || duo == 3 && trio >= 1
      else if (_lanzamientoplayer3.length > 0) {
        print("mano ganadora _lanzamientoplayer3. ");
        // _frase_juego = "Results in " + _contador_mostrardados.toString();
        _lanzamientoplayer_winnershow = _lanzamientoplayer3;
        //no
        //_conteomostrarwinner(_lanzamientoplayer1, 2);
        if (_lanzamientoplayer3.length == 1) {
          //
          _ver_invisible = true;

          _71_repartirdireno(one, _lanzamientoplayer3, "+ 4 dados iguales");
        }
        if (_lanzamientoplayer3.length > 1) {
          //
          _ver_invisible = true;

          _71_repartirdireno(one, _lanzamientoplayer3, " + 4 dados iguales2");
        }
      }
      //4. solo un par y un trio
      else if (_lanzamientoplayer4.length > 0) {
        print("mano ganadora _lanzamientoplayer4. ");
        _ver_invisible = true; //por  uw da error?

        _lanzamientoplayer_winnershow = _lanzamientoplayer4;

        //muestra un nombre si hay un ganador
        //  _frase_juego =_mesadados_principal.lanzamientoplayer[i].nombreplayer;

        if (_lanzamientoplayer4.length == 1) {
          //
          //  _frase_juego =_mesadados_principal.lanzamientoplayer[i].nombreplayer;
          //invalid argument aqui?
          _71_repartirdireno(one, _lanzamientoplayer4, "1 duo o 1 trio");
          //
          //  break;
        }
        if (_lanzamientoplayer4.length > 1) {
          //
          _ver_invisible = true; //por  uw da error?

          _71_repartirdireno(one, _lanzamientoplayer4, "1 duoo 1 trio");

          //   break;

        }
      }
      //5 los que no tenian nada
      else if (_lanzamientoplayer5.length > 0 &&
          _lanzamientoplayer_winnershow.length == 0) {
        print("mano ganadora _lanzamientoplayer. ");
        _lanzamientoplayer_winnershow = _lanzamientoplayer5;

        _ver_invisible = true;
        if (_lanzamientoplayer5.length == 1) {
          //
          //  _frase_juego =_mesadados_principal.lanzamientoplayer[i].nombreplayer;
          _71_repartirdireno(one, _lanzamientoplayer5, "3 pares o 2 trios");
        }
        if (_lanzamientoplayer5.length > 1) {
          //
          _71_repartirdireno(one, _lanzamientoplayer5, "nadie gana +2");

          // break;
        }
      }
      //
    }

    //----------------------------------VISTAS
    ////--vistas
    print("visible:" + _ver_invisible.toString());
    print(_lanzamientoplayer_winnershow.length);
    if (_mesadados_principal.apuestafinal < 100) {
      _frase_juego = " ";
    }

    ///
    //1. vista cuando ya terminamos la partida y todos esta en false
    if (_iniciarpartida != false) {
      _frase_juego = "Entrar en la mesa ";
      return Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Visibility(
                child: Container(
                  // alignment: Alignment.centerRight,//no
                  // width: double.infinity,
                  color: Colors.white38,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: util_texts_black2_agregattamano(_frase_juego, 2),
                  ),
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: true, //_ver_invisible,
              ),
              util_texts_white_2_agregattamano(
                  "Players " + "$totalplayers_on", 0.5),
              animacion_inicio_partida(
                  _lanzamientoplayer_winnershow, _mesadados_principal),
            ],
          ));
    }
    //-si la aprtida inicio correctamente //_iniciarpartida != true y no muestra nada
    if (_ver_invisible != false && _lanzamientoplayer_winnershow.length > 0) {
      return Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Visibility(
                child: Container(
                  // alignment: Alignment.centerRight,//no
                  // width: double.infinity,
                  color: Colors.white38,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: util_texts_black2_agregattamano(_frase_juego, 2),
                  ),
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: true, //_ver_invisible,
              ),
              util_texts_white_2_agregattamano(
                  "Players " + "$totalplayers_on", 0.5),
              animar_ganador(
                  1, _lanzamientoplayer_winnershow, _mesadados_principal),
            ],
          ));
    }
    //mesa 5 dados
    if (_ver_invisible != true && _iniciarpartida != true) {
      return Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Visibility(
                child: Container(
                  // alignment: Alignment.centerRight,//no
                  // width: double.infinity,
                  color: Colors.white30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: util_texts_black2_agregattamano(_frase_juego, 2),
                  ),
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: true, //_ver_invisible,
              ),
              util_texts_white_2_agregattamano(
                  "Players " + "$totalplayers_on", 0.5),
              Row(
                children: <Widget>[
                  _dado1_mesa(_mesadados_principal.d1),
                  _dado1_mesa(_mesadados_principal.d2),
                  _dado1_mesa(
                    (_mesadados_principal.d3),
                  )
                ],
              ),
              Container(
                //  alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: <Widget>[
                    _dado1_mesa(_mesadados_principal.d4),
                    _dado1_mesa(_mesadados_principal.d5),
                  ],
                ),
              ),
            ],
          ));
    }
  }

  //no lo use por 2 errorres que em dan aveces
  _conteomostrarwinner(List<Lanzamientoplayer> _lanzamientoplayer1, int) {
    _frase_juego = "Results in " + _contador_mostrardados.toString();
    const oneSec = const Duration(seconds: 1);
    var one = _mesadados_principal.apuestafinal;
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_contador_mostrardados == 0) {
          //_ver_invisible = true;
          if (_lanzamientoplayer1.length == 1) {
            //
            _71_repartirdireno(one, _lanzamientoplayer1, "+ 4 dados iguales");
            //   _ver_invisible = false;
          }
          if (_lanzamientoplayer1.length > 1) {
            //
            _71_repartirdireno(one, _lanzamientoplayer1, " + 4 dados iguales2");
            //  _ver_invisible = false;
          }
        } else {
          setState(() {
            _contador_mostrardados--;
          });
        }
      },
    );
  }

  //7.1 repartir dinero entre los jugadores que ganan
  _71_repartirdireno(
      double one, List<Lanzamientoplayer> _lanzamientoplayer1, String ganopor) {
    int winners =
        _lanzamientoplayer1.length; //total de jugadroes que han ganado
    _frase_juego =
        winners.toString() + " " + ganopor; //"winners " + winners.toString();
    //
    int jugadores_winner = _lanzamientoplayer1.length;
    var _monedas = one / jugadores_winner; //aveces se lleva 300 //son 200
    //int _monedas =( one ~/ jugadores_winner).round(); //aveces se lleva 300
    print("monedas " + _monedas.toString());
    print("one final " + one.toString());

    _verdado_showdados = false; //no msotrar los dados si no al ganador

    for (var j = 0; j < _lanzamientoplayer1.length; j++) {
      //asignamos el dinero a los ganadores
      for (var k = 0; k < _mesadados_principal.lanzamientoplayer.length; k++) {
        //si tienen el mismo id y reparten el dienro

        if (_lanzamientoplayer1[j].uid ==
            _mesadados_principal.lanzamientoplayer[k].uid) {
          //
          _mesadados_principal.lanzamientoplayer[k].fichasplayer =
              _mesadados_principal.lanzamientoplayer[k].fichasplayer + _monedas;

          _mesadados_principal.ganador = _lanzamientoplayer1[j].uid;
          if (j == _lanzamientoplayer1.length) {
            break;
          }

          //guarda la partida ganada
          //mostrar dialogo del ganador pues ya existe

          // guardar_partidasganadas(_mesadados_principal, _monedas);

        }
      }
    }

    //mostrar ganadores lista de nombre s
  }

//para complementar cuando no ganan
  _72_repartirdinero_lacasagana(
      double one, List<Lanzamientoplayer> _lanzamientoplayer1, String ganopor) {
    int winners =
        _lanzamientoplayer1.length; //total de jugadroes que han ganado
    _frase_juego =
        winners.toString() + " " + ganopor; //"winners " + winners.toString();
    //
    int jugadores_winner = _lanzamientoplayer1.length;
    var _monedas = one / jugadores_winner; //aveces se lleva 300 //son 200
    //int _monedas =( one ~/ jugadores_winner).round(); //aveces se lleva 300
    print("monedas " + _monedas.toString());
    print("one final " + one.toString());
    _verdado_showdados = false; //no msotrar los dados si no al ganador

    //mostrar ganadores lista de nombre s
  }

  _8_dadosanimacion() {
    List<Lanzamientoplayer> _lanzamientoplayer = [];
    int dado1 = 0, dado2 = 0;

    //leer /on player/turno on /d1!=0
    for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
      if (_mesadados_principal.lanzamientoplayer[i].onplayer != false &&
          _mesadados_principal.lanzamientoplayer[i].turno != false) {
        _lanzamientoplayer.add(_mesadados_principal.lanzamientoplayer[i]);
        //trato de mostrar el dado cuando este cambia de valor
        if (_mesadados_principal.lanzamientoplayer[i].dado1 != 0 &&
            _mesadados_principal.lanzamientoplayer[i].dado2 != 0) {
          dado1 = _mesadados_principal.lanzamientoplayer[i].dado1;
          dado2 = _mesadados_principal.lanzamientoplayer[i].dado2;
          _verdado_showdados = true;
          jugadorenturno_name =
              _mesadados_principal.lanzamientoplayer[i].nombreplayer;
        } else {
          _verdado_showdados = false;
        }
      }
    }
    //mostrar vista
    if (_verdado_showdados != false) {
      return Visibility(
        child: GestureDetector(
          onTap: () {
            _verdado_showdados = false;
          },
          child: Container(
            //padding: EdgeInsets.only(right: 30, bottom: 20),
            padding: const EdgeInsets.only(top: 80),

            alignment: Alignment.center, //no

            // width: double.infinity,
            //  color: Colors.white38,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  animardado_player(dado1, dado2, jugadorenturno_name),
                ],
              ),
            ),
          ),
        ),
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: true, //_ver_invisible,
      );
    } else {
      return Container();
    }
  }

  // SI LA ORIENTACION horizontal
  //no

//--------
  _mesaprincipal_firestore(String mesa) async {
    var busqueda1 = FirebaseFirestore.instance.collection('mesadados');

    await busqueda1
        .orderBy('timestamp', descending: false)
        // .where("partida", isEqualTo: mesa)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      querySnapshot.docs.forEach((doc) {
        Mesadados _snap_mesa = Mesadados.fromdocument(doc);

        List<Lanzamientoplayer> _lanzamientoplayer = [];

        for (var i = 0;
            i < _mesadados_principal.lanzamientoplayer.length;
            i++) {
          if (_mesadados_principal.lanzamientoplayer[i].onplayer != false) {
            _lanzamientoplayer.add(_mesadados_principal.lanzamientoplayer[i]);
            //trato de mostrar el dado cuando este cambia de valor

          }
        }
        setState(() {
          totalplayers_on = _lanzamientoplayer.length;

          _mesadados_principal = _snap_mesa;
        });

        print("buscando --------------------");
        print(_snap_mesa);
        print(_snap_mesa.lanzamientoplayer);
      });
    });
  }

  void _nombreusuarioenturno() {
    List<Lanzamientoplayer> _lanzamientoplayer = [];
    int dado1 = 0, dado2 = 0;

    //leer /on player/turno on /d1!=0
    for (var i = 0; i < _mesadados_principal.lanzamientoplayer.length; i++) {
      if (_mesadados_principal.lanzamientoplayer[i].onplayer != false &&
          _mesadados_principal.lanzamientoplayer[i].turno != false) {
        _lanzamientoplayer.add(_mesadados_principal.lanzamientoplayer[i]);

        jugadorenturno_name =
            _mesadados_principal.lanzamientoplayer[i].nombreplayer;
        /* //trato de mostrar el dado cuando este cambia de valor
        if (_mesadados_principal.lanzamientoplayer[i].dado1 != 0 &&
            _mesadados_principal.lanzamientoplayer[i].dado2 != 0) {
         // dado1 = _mesadados_principal.lanzamientoplayer[i].dado1;
         // dado2 = _mesadados_principal.lanzamientoplayer[i].dado2;
          _verdado_showdados = true;
        
        }*/
      }
    }
  }

  void _cargarpreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('auth');
    nombre_c = prefs.getString("nombreweb")!;
    foto_c = prefs.getString("fotoweb")!;
    _uid = prefs.getString("tokenweb")!;
  }
}
