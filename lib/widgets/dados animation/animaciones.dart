import 'package:criptodadosweb/pagues/criptogame/dados/provider_dados_dagme.dart';
import 'package:criptodadosweb/pagues/models/juegodados/model_mesadados.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:criptodadosweb/utils/utils_textos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

List<Lanzamientoplayer> _lanzamientoplayer_class = [];
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
//anima al ganador y renicia la partida
animar_ganador(
    int i, List<Lanzamientoplayer> _lanzamientoplayer1, Mesadados mesadados) {
//regresa el dado animado
  _lanzamientoplayer_class = _lanzamientoplayer1;
  _mesadados_principal = mesadados;
  AnimationController animateController;
  for (var i = 0; i < mesadados.lanzamientoplayer.length; i++) {
    if (_mesadados_principal.lanzamientoplayer[i].uid ==
        _lanzamientoplayer1[0].uid) {
      _mesadados_principal.lanzamientoplayer[i].turno = true;
      break;
    }
  }

  //
  return Container(
      padding: EdgeInsets.only(right: 50), //mala idea se ve feo
      alignment: Alignment.center,
      child: BounceInDown(
        controller: (controller) => animateController = controller,
        child:
            vistaganador1(), // aqui veamos lo qeu necesitemosdebe usar un build context
        duration: Duration(seconds: 5),
      ));
}

class vistaganador1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      //  width: 400,
      // height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  /*  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image(
                        image: AssetImage("assets/1fondoverde.png"),
                        fit: BoxFit.cover),
                  ),*/
                  Container(
                    // height: 200,
                    width: double.infinity,
                    child: Image(
                        image: AssetImage("assets/fichasgif1.gif"),
                        fit: BoxFit.cover),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                util_texts_black2_agregattamano(
                                    _lanzamientoplayer_class[0].nombreplayer,
                                    2),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.white,
                                child: util_texts_black2_agregattamano(
                                    _mesadados_principal.apuestafinal
                                        .toString(),
                                    2),
                              ),
                              Container(
                                //  alignment: Alignment.centerLeft,
                                //  padding: EdgeInsets.only(left: 40),
                                child: Row(
                                  children: <Widget>[
                                    _dado1_mesa(
                                        _lanzamientoplayer_class[0].dado1),
                                    _dado1_mesa(
                                        _lanzamientoplayer_class[0].dado2),
                                    _dado1_mesa(_mesadados_principal.d1),
                                    _dado1_mesa(_mesadados_principal.d2),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  _dado1_mesa(_mesadados_principal.d3),
                                  _dado1_mesa(_mesadados_principal.d4),
                                  _dado1_mesa(_mesadados_principal.d5),
                                ],
                              ),
                              /* Container(
                                //  alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 40),
                                child: Row(
                                  children: <Widget>[
                                    _dado1_mesa(_mesadados_principal.d4),
                                    _dado1_mesa(_mesadados_principal.d5),
                                  ],
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {
                  //guardar y jugar de neuvo

                  asignar_ganadores_yreiniciarjuego(_mesadados_principal);
                },
                child: Text(
                  'Nueva Partida',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
            side: BorderSide(width: 1, color: Colors.white)),
        child: Container(
          child: Container(
            child: ClipRRect(
              child: Expanded(child: Image(image: AssetImage(dadoselec1))),
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
      borderRadius: BorderRadius.circular(20),
    ),
  );
}

//----
//001-animacion de iniciar partida cuando todos estan off
animacion_inicio_partida(
    List<Lanzamientoplayer> _lanzamientoplayer1, Mesadados _mesadados) {
  _lanzamientoplayer_class = _lanzamientoplayer1;
  _mesadados_principal = _mesadados;
  AnimationController animateController;

  final _pref_shared = new PreferenciasUsuario();
  for (var i = 0; i < _mesadados.lanzamientoplayer.length; i++) {
    if (_mesadados_principal.lanzamientoplayer[i].uid == _pref_shared.token) {
      //primer jugador en turno
      _mesadados_principal.lanzamientoplayer[i].turno = true;
      break;
    }
  }
  return Container(
      // alignment: Alignment.center,
      child: BounceInDown(
    controller: (controller) => animateController = controller,
    child:
        iniciar_partida_panel(), // aqui veamos lo qeu necesitemosdebe usar un build context
    duration: Duration(seconds: 3),
  ));
}

//001.1
class iniciar_partida_panel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image(
                        image: AssetImage("assets/fichasgif1.gif"),
                        fit: BoxFit.cover),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            child:
                                util_texts_black2_agregattamano("Welcome ", 2),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            child: util_texts_black2_agregattamano(
                                100.toString(), 2),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {
                  //guardar y jugar de neuvo

                  //  actualizar_siguientejugador(_lanzamientoplayer_class[0], _mesadados_principal);
                  asignarprimerturno(_mesadados_principal);
                },
                child: util_texts_white_2_agregattamano("play", 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//-----------------------
//002--animacion dado callendo prueba 1
int _d1_playerdado = 0;
int _d2_playerdado = 0;
String _jugadorenturno = "";
//
animardado_player(int d1, int d2, String jugador) {
  AnimationController animateController;
  _d1_playerdado = d1;
  _d2_playerdado = d2;
  _jugadorenturno = jugador;
  return Container(
    height: 160,
    width: 150,
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.only(top: 10),
    child: BounceInDown(
      controller: (controller) => animateController = controller,
      child: Column(
        children: [
          util_texts_white_2_agregattamano(_jugadorenturno, 0.7),
          //  util_texts_black2_agregattamano(_jugadorenturno, 1),
          Row(children: [
            lanzardado_playerd1(),
            lanzardado_playerd2(),
          ]),
        ],
      ), // aqui veamos lo qeu necesitemosdebe usar un build context

      duration: Duration(seconds: 5),
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 1.0,
          offset: Offset(0, 5), //0,5
          spreadRadius: 0.2, //4 en 2 se ve mas suave
        ),
      ],
      borderRadius: BorderRadius.circular(80),
    ),
  );
}

class lanzardado_playerd1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    String dadoselec1 = "";
    String dadoselec2 = "";
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

    //
    return Container(
      width: 60,
      height: 90,
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.grey[900],
              ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    child:
                        Image(image: AssetImage(dadoselec1), fit: BoxFit.cover),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            child: util_texts_black2_agregattamano(
                                _d1_playerdado.toString(), 2),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class lanzardado_playerd2 extends StatelessWidget {
  String dadoselec2 = "";
  String d1 = "assets/dado1_anim.gif";
  String d2 = "assets/dado2_anim.gif";
  String d3 = "assets/dado3_anim.gif";
  String d4 = "assets/dado4_anim.gif";
  String d5 = "assets/dado5_anim.gif";
  String d6 = "assets/dado6_anim.gif";

  @override
  Widget build(BuildContext context) {
    //---dado 2
    if (_d2_playerdado == 1) {
      dadoselec2 = d1;
    }
    if (_d2_playerdado == 2) {
      dadoselec2 = d2;
    }
    if (_d2_playerdado == 3) {
      dadoselec2 = d3;
    }
    if (_d2_playerdado == 4) {
      dadoselec2 = d4;
    }
    if (_d2_playerdado == 5) {
      dadoselec2 = d5;
    }
    if (_d2_playerdado == 6) {
      dadoselec2 = d6;
    }
    return Container(
      alignment: Alignment.center,
      width: 60,
      height: 90,
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.grey[900],
              ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    child:
                        Image(image: AssetImage(dadoselec2), fit: BoxFit.cover),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            child: util_texts_black2_agregattamano(
                                _d2_playerdado.toString(), 2),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
