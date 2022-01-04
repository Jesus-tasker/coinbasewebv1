import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/pagues/criptogame/v2/provider1_ibuscarpartida.dart';
import 'package:criptodadosweb/pagues/models/juegodados/fichas_virtuales.dart';
import 'package:criptodadosweb/pagues/models/juegodados/model_mesadados.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';

import 'package:flutter/material.dart';

var busqueda1 = FirebaseFirestore.instance.collection('mesadados');
//contador minutos
TweenAnimationBuilder<Duration> contador_minutos4 =
    new TweenAnimationBuilder<Duration>(
        duration: Duration(minutes: 1, seconds: 30),
        tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
        onEnd: () {
          print('Timer ended');
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text('$minutes:$seconds',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)));
        });
//incompleto hay que jugar por el
Future jugadores_nojugo(
    Lanzamientoplayer lanzamientoplayer, Mesadados mesadados) async {
  // busqueda1.orderBy('timestamp', descending: false)
  //   .where("partida", isEqualTo: mesadados.partida.toString());
  //lista jugadores on
  int numerolistaplayer = 0;
  List<Lanzamientoplayer> lista_positions = [];
  for (var i = 0; i < mesadados.lanzamientoplayer.length; i++) {
    //userson
    if (mesadados.lanzamientoplayer[i].onplayer == true) {
      //1,3,4 //on
      lista_positions.add(
          mesadados.lanzamientoplayer[i]); //comrpara con todos los usuarios

      ////user en turno
      if (mesadados.lanzamientoplayer[i].uid == lanzamientoplayer.uid &&
          mesadados.lanzamientoplayer[i].turno == true) {
        numerolistaplayer = i; //posicion en lista principal
        lanzamientoplayer.turno = false; //ya jugo igual

        var a = lanzamientoplayer.timesplayer;
        var long1 = double.parse('$a');
        var timer1 = long1 * 1000; //1 el  jugador que no jugo
        //numero d ela lista de firebase
        if (numerolistaplayer < 5) {
          //1,2, 3, next
          if (numerolistaplayer == 1) {
            if (mesadados.lanzamientoplayer[i + 1].onplayer != false) {
              mesadados.lanzamientoplayer[i + 1].turno = true;
              mesadados.lanzamientoplayer[i + 1].timesplayer =
                  timestamp_obtenercodigo();
            } else if (mesadados.lanzamientoplayer[i + 2].onplayer != false) {
              mesadados.lanzamientoplayer[i + 2].turno = true;
              mesadados.lanzamientoplayer[i + 2].timesplayer =
                  timestamp_obtenercodigo();
            } else if (mesadados.lanzamientoplayer[i + 3].onplayer != false) {
              mesadados.lanzamientoplayer[i + 3].turno = true;
              mesadados.lanzamientoplayer[i + 3].timesplayer =
                  timestamp_obtenercodigo();
            }
          }
          if (numerolistaplayer == 2) {
            //3
            if (mesadados.lanzamientoplayer[i + 1].onplayer != false) {
              mesadados.lanzamientoplayer[i + 1].turno = true;
              mesadados.lanzamientoplayer[i + 1].timesplayer =
                  timestamp_obtenercodigo();
            } else if (mesadados.lanzamientoplayer[i + 2].onplayer != false) {
              mesadados.lanzamientoplayer[i + 2].turno = true;
              mesadados.lanzamientoplayer[i + 2].timesplayer =
                  timestamp_obtenercodigo();
            } else if (mesadados.lanzamientoplayer[0].onplayer != false) {
              mesadados.lanzamientoplayer[0].turno = true;
              mesadados.lanzamientoplayer[0].timesplayer =
                  timestamp_obtenercodigo();
            }
          }
          if (numerolistaplayer == 3) {
            if (mesadados.lanzamientoplayer[i + 1].onplayer != false) {
              mesadados.lanzamientoplayer[i + 1].turno = true;
              mesadados.lanzamientoplayer[i + 1].timesplayer =
                  timestamp_obtenercodigo();
            } else if (mesadados.lanzamientoplayer[i + 2].onplayer != false) {
              mesadados.lanzamientoplayer[i + 2].turno = true;
              mesadados.lanzamientoplayer[i + 2].timesplayer =
                  timestamp_obtenercodigo();
            } else if (mesadados.lanzamientoplayer[i - 1].onplayer != false) {
              mesadados.lanzamientoplayer[i - 1].turno = true;
              mesadados.lanzamientoplayer[i - 1].timesplayer =
                  timestamp_obtenercodigo();
            }
          }

          /* for (var j = 0; j < lista_positions.length; j++) {
            //quien sigue en la lista?
            var b = lista_positions[j].timesplayer;
            var long2 = double.parse('$b');
            var timer2 = long2 * 1000; //2el  jugador que deberia seguir

            //horap1>horap
            if (timer2 > timer1) {
              //en teoria aqui obtengo al que esta despues
              lista_positions[j].turno = true;
            }
          }*/
        } else {
          //4
          //va el jugador 1
          mesadados.lanzamientoplayer[0].turno = true;
          mesadados.lanzamientoplayer[0].timesplayer =
              timestamp_obtenercodigo();
        }

        //2si no ha aapostado
        /*if (lanzamientoplayer.apuestaminima == 0) {
          mesadados.lanzamientoplayer[i] = lanzamientoplayer;
          break;
          //next player

        }
        //si ha apostado
        if (lanzamientoplayer.apuestaminima > 0) {
          if (lanzamientoplayer.dado1 != null && lanzamientoplayer.dado1 != 0) {
            //ya lanzo dados

            mesadados.lanzamientoplayer[i] = lanzamientoplayer;
          } else {
            //lanzar dados
            Random random = new Random();
            int d1 = random.nextInt(6);
            int d2 = random.nextInt(6);

            lanzamientoplayer.turno = false;
            mesadados.lanzamientoplayer[i] = lanzamientoplayer;
          }
          if (i != 4) {
            mesadados.lanzamientoplayer[i + 1].turno = true;
          } else {
            mesadados.lanzamientoplayer[0].turno = true;
          }
        }*/
      } else {
        //check ,fold ,raised
      }
    }
  }

  //jugador en turno =false,

  busqueda1
      .doc(mesadados.partida.toString())
      .update(mesadados.toJson())
      .then((value) => print("jugador no jugo"));
}

//-0001, NO LO USE AL FINAL
Future player_no_aposto(
    Lanzamientoplayer lanzamientoplayer, Mesadados mesadados) async {
  int numerolistaplayer = 0;
  List<Lanzamientoplayer> lista_on_nexplayer = [];
  for (var i = 0; i < mesadados.lanzamientoplayer.length; i++) {
    //userson
    if (mesadados.lanzamientoplayer[i].onplayer == true) {
      lista_on_nexplayer.add(mesadados.lanzamientoplayer[i]);
      ////user en turno
      if (mesadados.lanzamientoplayer[i].uid == lanzamientoplayer.uid &&
          mesadados.lanzamientoplayer[i].turno == true) {
        numerolistaplayer = i;
        lanzamientoplayer.turno = false; //ya jugo igual
        print(lanzamientoplayer.uid);

        //2si no ha aapostado

        if (lanzamientoplayer.apuestaminima == 0) {
          lanzamientoplayer.onplayer = false;
          lanzamientoplayer.turno = false;
          mesadados.lanzamientoplayer[i] = lanzamientoplayer;
        } else {
          break;
        }
        //si ha apostado

      }
    }
  }

  //jugador en turno =false,

  busqueda1.doc(mesadados.partida.toString()).update(mesadados.toJson());
}

//000-2, controller de la mesa para cambiar los datos del jugador conforme su cituacion
Future player_play_dados(Lanzamientoplayer lanzamientoplayer,
    Mesadados mesadados, int estado, double apuesta) async {
  // busqueda1.orderBy('timestamp', descending: false)
  //   .where("partida", isEqualTo: mesadados.partida.toString());
  //lista jugadores on
  //check
  //CHECK
  // if (estado == 1) {}

  //raised
  // if (estado == 3) {}
  int numerolistaplayer = 0;
  List<Lanzamientoplayer> lista_on_nexplayer = [];
  for (var i = 0; i < mesadados.lanzamientoplayer.length; i++) {
    //users on priemra lista general
    if (mesadados.lanzamientoplayer[i].onplayer == true) {
      lista_on_nexplayer.add(mesadados.lanzamientoplayer[i]);
      ////user en turno
      if (mesadados.lanzamientoplayer[i].uid == lanzamientoplayer.uid &&
          mesadados.lanzamientoplayer[i].turno == true) {
        numerolistaplayer = i;

        //fold X salir de la partida actual
        if (estado == 2) {
          lanzamientoplayer.times_int = timestamp_obtenercodigo_int();
          lanzamientoplayer.timesplayer = timestamp_obtenercodigo();

          if (lanzamientoplayer.apuestaminima <= 0) {
            //   lanzamientoplayer.onplayer = false;
            // lanzamientoplayer.turno = false;
            mesadados.lanzamientoplayer[i] = lanzamientoplayer;
            actualizar_siguientejugador(lanzamientoplayer, mesadados);
            break;
          } else {
            //   lanzamientoplayer.onplayer = false;
            // lanzamientoplayer.turno = false;
            mesadados.lanzamientoplayer[i] = lanzamientoplayer;
            actualizar_siguientejugador(lanzamientoplayer, mesadados);
            break;
          }
        }
        //check pagar o ir y al tiempo empezar el juego
        if (estado == 1) {
          //0 iniciar apuesta minima
          if (lanzamientoplayer.apuestaminima == 0) {
            //avanzar y apostar lo minimo -primera vez
            if (mesadados.apuestabase > lanzamientoplayer.apuestaminima) {
              //
              // entrar en la mesa
              //100 /100
              if (apuesta >= mesadados.apuestabase) {
                lanzamientoplayer.apuestaminima = mesadados.apuestabase; //+100
                lanzamientoplayer.fichasplayer =
                    lanzamientoplayer.fichasplayer - apuesta;
                double totalacumulado = mesadados.apuestabase + apuesta;

                mesadados.apuestafinal = totalacumulado;
                // lanzamientoplayer.times_int = timestamp_obtenercodigo_int();

                // var dinner_recolected = mesadados.apuestabase + apuesta;
                //mesadados.apuestafinal = dinner_recolected.toString();
                // lanzamientoplayer.apuestaminima = dinner_recolected;

                mesadados.lanzamientoplayer[i] = lanzamientoplayer;
                //guardar primero la partida ganada

                actualizar_siguientejugador(lanzamientoplayer, mesadados);
                break;
              }
            }
          }
          //1 continuar sin aumentar con la  misma apuesta
          if (lanzamientoplayer.apuestaminima > 10) {
            //1.1 apuesta y lanza los adados
            if (mesadados.apuestabase <= lanzamientoplayer.apuestaminima &&
                // mesadados.status != true &&
                lanzamientoplayer.dado1 == 0 &&
                lanzamientoplayer.dado2 == 0) {
              //
              // entrar en la mesa
              //100 /100
              //no hacemos casi cambios ya que continua solo siguente jugador
              //lanzamientoplayer.apuestaminima = mesadados.apuestabase; //+100
              //  lanzamientoplayer.fichasplayer =lanzamientoplayer.fichasplayer - apuesta;
              //int totalacumulado = mesadados.apuestabase + apuesta;

              // mesadados.apuestafinal = totalacumulado.toString();
              lanzamientoplayer.times_int = timestamp_obtenercodigo_int();
              lanzamientoplayer.timesplayer = timestamp_obtenercodigo();

              // var dinner_recolected = mesadados.apuestabase + apuesta;
              //mesadados.apuestafinal = dinner_recolected.toString();
              // lanzamientoplayer.apuestaminima = dinner_recolected;
              mesadados.status =
                  true; //ya empezo a jugar la aprtida con apuesta
              Random random = new Random();
              int ran_dado1 = 1 + random.nextInt(5);
              int ran_dado2 = 1 + random.nextInt(5);

              lanzamientoplayer.dado1 = ran_dado1;
              lanzamientoplayer.dado2 = ran_dado2;

              mesadados.lanzamientoplayer[i] = lanzamientoplayer;

              actualizar_siguientejugador(lanzamientoplayer, mesadados);
              break;
            }
            //  //1.1 ya ha apostado el juego continua  en este caso deberia lanzarce los primeros 3 dadoss
            if (mesadados.apuestabase <= lanzamientoplayer.apuestaminima &&
                mesadados.status != false &&
                lanzamientoplayer.dado1 != 0 &&
                lanzamientoplayer.dado2 != 0) {
              lanzamientoplayer.times_int = timestamp_obtenercodigo_int();
              lanzamientoplayer.timesplayer = timestamp_obtenercodigo();
              //1.3 si aun no ha lanzado los 3 dados la mesa
              if (mesadados.d1 == 0 &&
                  mesadados.d2 == 0 &&
                  mesadados.d3 == 0 &&
                  lanzamientoplayer.dado1 != 0 &&
                  lanzamientoplayer.dado2 != 0) {
                mesadados.lanzamientoplayer[i] = lanzamientoplayer;

                Random random = new Random();
                int ran_dado1 = 1 + random.nextInt(5);
                int ran_dado2 = 1 + random.nextInt(5);
                int ran_dado3 = 1 + random.nextInt(5);

                mesadados.d1 = ran_dado1;
                mesadados.d2 = ran_dado2;
                mesadados.d3 = ran_dado3;

                //d1,d2,d3
                actualizar_siguientejugador(lanzamientoplayer, mesadados);
                break;
              }
              //1.4 si ya se han lanzado los primeros 3 dados faltan los ultimos 2

              if (mesadados.d1 != 0 &&
                  mesadados.d2 != 0 &&
                  mesadados.d3 != 0 &&
                  mesadados.d4 == 0 &&
                  mesadados.d5 == 0 &&
                  lanzamientoplayer.dado1 != 0 &&
                  lanzamientoplayer.dado2 != 0) {
                mesadados.lanzamientoplayer[i] = lanzamientoplayer;
                Random random = new Random();
                int ran_dado4 = 1 + random.nextInt(5);
                int ran_dado5 = 1 + random.nextInt(5);

                mesadados.d4 = ran_dado4;
                mesadados.d5 = ran_dado5;
                //d4,d5
                actualizar_siguientejugador(lanzamientoplayer, mesadados);
                break;
              }
            }
          }
        }

        //2si no ha aapostado

        //si ha apostado

      }
    }
  }

  //jugador en turno =false,

  // busqueda1.doc(mesadados.partida.toString()).update(mesadados.toJson());
}

Future salirmesa1(
    Mesadados mesadados, BuildContext context, double monedas_ganadas) async {
  var registro_ultima_partida =
      FirebaseFirestore.instance.collection('Jugadas_usario');
  var busqueda_cash2_uid = FirebaseFirestore.instance
      .collection('FichasXusuario'); //ruta directa uid

  //guardar monedas y luego
  final _pref = PreferenciasUsuario();
//0
  busqueda1
      .doc(mesadados.partida.toString())
      .update(mesadados.toJson())
      .then((value) => print("actualziada"));

  //1.registrar partida

  registro_ultima_partida
      .doc("partida")
      .collection(_pref.token)
      .doc(mesadados.timestamp)
      .set(mesadados
          .toJson()) //registro ultima aprtida en que jugo gano o perdio
      .then((value) async {
    //2 guardar las fichas
    var fichas_tofire = Fichas_virtuales(
        fichas: monedas_ganadas,
        timestampSting: mesadados.timestamp,
        timestampint: timestamp_obtenercodigo_int());
    //+100 o 100
    await busqueda_cash2_uid
        .doc("fichas")
        .collection(_pref.token)
        .doc(mesadados.timestamp)
        .set(fichas_tofire.toJson())
        .then((value) {
      //   var monedasuser = Fichas_virtuales.fromdocument(value);
      // double unidadfichas_fire = monedasuser.fichas.toDouble();
      // print("fichas_user" + unidadfichas_fire.toString());
      //
      double valor1 = _pref.fichas_1;
      _pref.fichas_1 = valor1 + monedas_ganadas;
      print("fichas------------");
      print(_pref.fichas_1.toString());
      Navigator.popAndPushNamed(
          context, 'navegador'); //se queda en negro pero funciona por ahora
      //  Navigator.pushNamed(context, 'navegador');
      // Navigator.pushReplacementNamed(context, 'navegador');
    });
  });
}

//000-3 asigna el siguiente jugador
Future actualizar_siguientejugador(
    Lanzamientoplayer lanzamientoplayer, Mesadados mesadados) async {
  // busqueda1.orderBy('timestamp', descending: false)
  //   .where("partida", isEqualTo: mesadados.partida.toString());
  //lista jugadores on
  int numerolistaplayer = 0;
  List<Lanzamientoplayer> lista_positions = [];
  //orden
  var randomNumbers = List.of({
    mesadados.lanzamientoplayer[0].times_int,
    mesadados.lanzamientoplayer[1].times_int,
    mesadados.lanzamientoplayer[2].times_int,
    mesadados.lanzamientoplayer[3].times_int,
    mesadados.lanzamientoplayer[4].times_int
  });
  randomNumbers.sort();
  //1633413248359
  //https://dev.to/codingpizza/funciones-increibles-que-debes-conocer-al-trabajar-con-dart-5cc2
  //1 ,5,8... aparecerian en orden teoriamente
  //prmeros 3
  /*var list = List.from([1,2,3,4,5,6]);
var topThreeList = list.take(3);
//1,2,3
print(topThreeList); 

var randomNumbers = List.of({14, 51, 23, 45, 6, 3, 22, 1});
var evenNumbers = randomNumbers.where((number => number.isEven));
print(evenNumbers);//14,6,22.
//podemos agregar la sentencia que queramos para organziar al lista 
*/

  //bucle principal
  for (var i = 0; i < mesadados.lanzamientoplayer.length; i++) {
    //1,3,4 //on
    ////user en turno
    if (mesadados.lanzamientoplayer[i].uid == lanzamientoplayer.uid &&
        mesadados.lanzamientoplayer[i].turno == true) {
      numerolistaplayer = i; //posicion en lista principal ej jugador 1
      lanzamientoplayer.turno = false; //ya jugo igual

      //numero d ela lista de firebase
      if (numerolistaplayer < 4) {
        //1,2, 3, next
        if (numerolistaplayer == 0) {
          if (mesadados.lanzamientoplayer[i + 1].onplayer != false) {
            mesadados.lanzamientoplayer[i + 1].turno = true;
            mesadados.lanzamientoplayer[i + 1].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 1].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[i + 2].onplayer != false) {
            mesadados.lanzamientoplayer[i + 2].turno = true;
            mesadados.lanzamientoplayer[i + 2].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 2].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[i + 3].onplayer != false) {
            mesadados.lanzamientoplayer[i + 3].turno = true;
            mesadados.lanzamientoplayer[i + 3].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 3].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[i + 4].onplayer != false) {
            mesadados.lanzamientoplayer[i + 4].turno = true;
            mesadados.lanzamientoplayer[i + 4].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 4].times_int =
                timestamp_obtenercodigo_int();
            break;
          }
        }
        if (numerolistaplayer == 1) {
          if (mesadados.lanzamientoplayer[i + 1].onplayer != false) {
            mesadados.lanzamientoplayer[i + 1].turno = true;
            mesadados.lanzamientoplayer[i + 1].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 1].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[i + 2].onplayer != false) {
            mesadados.lanzamientoplayer[i + 2].turno = true;
            mesadados.lanzamientoplayer[i + 2].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 2].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[i + 3].onplayer != false) {
            mesadados.lanzamientoplayer[i + 3].turno = true;
            mesadados.lanzamientoplayer[i + 3].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 3].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[0].onplayer != false) {
            mesadados.lanzamientoplayer[0].turno = true;
            mesadados.lanzamientoplayer[0].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[0].times_int =
                timestamp_obtenercodigo_int();
            break;
          }
        }
        if (numerolistaplayer == 2) {
          //3
          if (mesadados.lanzamientoplayer[i + 1].onplayer != false) {
            mesadados.lanzamientoplayer[i + 1].turno = true;
            mesadados.lanzamientoplayer[i + 1].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 1].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[i + 2].onplayer != false) {
            mesadados.lanzamientoplayer[i + 2].turno = true;
            mesadados.lanzamientoplayer[i + 2].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 2].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[0].onplayer != false) {
            mesadados.lanzamientoplayer[0].turno = true;
            mesadados.lanzamientoplayer[0].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[0].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[i - 1].onplayer != false) {
            mesadados.lanzamientoplayer[i - 1].turno = true;
            mesadados.lanzamientoplayer[i - 1].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i - 1].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[i - 2].onplayer != false) {
            mesadados.lanzamientoplayer[i - 2].turno = true;
            mesadados.lanzamientoplayer[i - 2].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i - 2].times_int =
                timestamp_obtenercodigo_int();
            break;
          }
        }
        //4
        if (numerolistaplayer == 3) {
          if (mesadados.lanzamientoplayer[i + 1].onplayer != false) {
            mesadados.lanzamientoplayer[i + 1].turno = true;
            mesadados.lanzamientoplayer[i + 1].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[i + 1].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[0].onplayer != false) {
            mesadados.lanzamientoplayer[0].turno = true;
            mesadados.lanzamientoplayer[0].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[0].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[1].onplayer != false) {
            mesadados.lanzamientoplayer[1].turno = true;
            mesadados.lanzamientoplayer[1].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[1].times_int =
                timestamp_obtenercodigo_int();
            break;
          } else if (mesadados.lanzamientoplayer[2].onplayer != false) {
            mesadados.lanzamientoplayer[2].turno = true;
            mesadados.lanzamientoplayer[2].timesplayer =
                timestamp_obtenercodigo();
            mesadados.lanzamientoplayer[2].times_int =
                timestamp_obtenercodigo_int();
            break;
          }
        }
      }
      if (numerolistaplayer == 4) {
        if (mesadados.lanzamientoplayer[0].onplayer != false) {
          mesadados.lanzamientoplayer[0].turno = true;
          mesadados.lanzamientoplayer[0].timesplayer =
              timestamp_obtenercodigo();
          mesadados.lanzamientoplayer[0].times_int =
              timestamp_obtenercodigo_int();
          break;
        } else if (mesadados.lanzamientoplayer[1].onplayer != false) {
          mesadados.lanzamientoplayer[1].turno = true;
          mesadados.lanzamientoplayer[1].timesplayer =
              timestamp_obtenercodigo();
          mesadados.lanzamientoplayer[1].times_int =
              timestamp_obtenercodigo_int();
          break;
        } else if (mesadados.lanzamientoplayer[2].onplayer != false) {
          mesadados.lanzamientoplayer[2].turno = true;
          mesadados.lanzamientoplayer[2].timesplayer =
              timestamp_obtenercodigo();
          mesadados.lanzamientoplayer[2].times_int =
              timestamp_obtenercodigo_int();
          break;
        } else if (mesadados.lanzamientoplayer[3].onplayer != false) {
          mesadados.lanzamientoplayer[3].turno = true;
          mesadados.lanzamientoplayer[3].timesplayer =
              timestamp_obtenercodigo();
          mesadados.lanzamientoplayer[3].times_int =
              timestamp_obtenercodigo_int();
          break;
        }
      }
    }
  }

  //jugador en turno =false,

  busqueda1
      .doc(mesadados.partida.toString())
      .update(mesadados.toJson())
      .then((value) => print("actualziada"));
}

//-0004 GANAR  Y REINICIAR PARTIDA
Future asignar_ganadores_yreiniciarjuego(Mesadados mesadados) async {
  //recibe la partida con los ganadores listos con el dinero

  //reiniciar players
  for (var i = 0; i < mesadados.lanzamientoplayer.length; i++) {
    mesadados.lanzamientoplayer[i].apuestaminima = 0;
    mesadados.lanzamientoplayer[i].dado1 = 0;
    mesadados.lanzamientoplayer[i].dado2 = 0;
    mesadados.lanzamientoplayer[i].turno = false;
  }

  mesadados.status = false; //no inicio segunda ronda
  mesadados.apuestafinal = 0;
  mesadados.d1 = 0;
  mesadados.d2 = 0;
  mesadados.d3 = 0;
  mesadados.d4 = 0;
  mesadados.d5 = 0;
  mesadados.ganador = "no";

  busqueda1
      .doc(mesadados.partida.toString())
      .update(mesadados.toJson())
      .then((value) => print("actualziada"));
}

//iniciamos al jugador actual con on player
Future asignarprimerturno(Mesadados mesadados) async {
  busqueda1
      .doc(mesadados.partida.toString())
      .update(mesadados.toJson())
      .then((value) => print("actualziada"));
}

//--------------------
Future guardar_partidasganadas(Mesadados mesadados, int monedas) async {
  var busqueda1 = FirebaseFirestore.instance.collection('winners');

  PreferenciasUsuario _prefusers = PreferenciasUsuario();
  //guardaat todo el json o solo las ganancias
  busqueda1.doc(_prefusers.token).collection("dados").add(mesadados.toJson());
}
