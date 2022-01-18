// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/pagues/login/gogogle_sing_provider.dart';
import 'package:criptodadosweb/pagues/models/juegodados/guardar_compra.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:criptodadosweb/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menuiniciov2 extends StatefulWidget {
  Menuiniciov2({Key? key}) : super(key: key);

  @override
  _Menuiniciov2State createState() => _Menuiniciov2State();
}

String nombre = "";
double fichasbit1 = 0;
double diamantes = 0;

class _Menuiniciov2State extends State<Menuiniciov2> {
  String foto_c =
      "https://conceptodefinicion.de/wp-content/uploads/2015/03/hombre.jpg";

  String background_fichas =
      "https://i.pinimg.com/originals/ee/f6/5e/eef65ee1a4e6a9a9036810fe1ddf9ba9.jpg";

  String back_fichas1 =
      "https://e7.pngegg.com/pngimages/260/681/png-clipart-logo-event-tickets-very-important-person-game-vip-logo-game-logo-thumbnail.png";

  String back_fichas_game =
      "https://images.vexels.com/media/users/3/151686/isolated/preview/45130c6d03b2256e6615f2a696195f41-icone-plano-de-gema-de-diamante.png";

  Color color_principal = const Color.fromARGB(58, 83, 10, 88); //violeta claro
  // Color color_principal = Color.fromRGBO(10, 100, 10, 0.1);
  // Color color_principal = Color.fromRGBO(10, 100, 10, 0.1);

  @override
  Widget build(BuildContext context) {
    var original = MaterialApp(
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        padding: const EdgeInsets.all(10),
        child: Expanded(
            flex: 9,
            child: Stack(
              children: <Widget>[
                //  _crearFondo(context),
                //_crear_fondo_fichas(context),
                // Expanded(child: Container(color:Colors.black),
                Container(color: Colors.black),

                Column(
                  children: [
                    _0_monedas_user(context),
                    // _00_reglas(context),
                  ],
                ),
                // _00_reglas(context), lo puse en monedas user

                // _1_opciones_partida(context),

                // _2_opciones_regalos_y_ventas(context),

                // _listaopciones(context), //usar para verificar que conoce o sabe cobre como usar
              ],
            )),
      ),
    );
    return Container(child: Text("pagina nueva "));
  }

  final _prefusers = PreferenciasUsuario();

  Widget _0_monedas_user(BuildContext context) {
    _cargarsharedpreferencesweb(); //yambien las monedas d efirebase

    if (_prefusers.foto != "") {
      foto_c = _prefusers.foto;
    }
    if (_prefusers.nombre != "") {
      nombre = _prefusers.nombre;
    }
    if (_prefusers.fichas_1 != 0.0) {
      fichasbit1 = _prefusers.fichas_1;
      print("fichas " + fichasbit1.toString());
    }
    if (_prefusers.diamantes != 0.0) {
      diamantes = _prefusers.diamantes;
      print("diamantes" + diamantes.toString());
    }
    // final _screensize =MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla

    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: const Color.fromARGB(255, 54, 1,
          63), // color_principal, //al inicio dle codigo linea 41 prox
      // height: _screensize.height * 0.18,
      width: double.infinity,
      child: Column(
        children: [
          //informacion completa usuario monedas y btn salida
          Row(
            children: <Widget>[
              /* Container(
                height: double.infinity,
                child: Expanded(child: Icon(Icons.home)),
              ),*/

              //player
              Container(
                //  width: 80,
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    const Text(" "),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color.fromARGB(255, 211, 201,
                            113), // Color.fromRGBO(50, 20, 200, 0.8),
                        child: CircleAvatar(
                          //   radius: 30,
                          // child: Image.asset('assets/logo1.png'),
                          backgroundImage: NetworkImage(foto_c),
                          radius: 35,

                          //  borderColor: Colors.yellow,
                        ),
                      ),
                    ),
                    Container(
                      // width: 100,
                      alignment: Alignment.bottomCenter,
                      child: Text(nombre,
                          textScaleFactor: 0.3,
                          maxLines: 8,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              decoration: TextDecoration.none)),
                    ),
                  ],
                ),
              ),
              //datos coins,
              Container(
                child: Column(
                  children: <Widget>[
                    //expreiencia
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.stars_sharp,
                          color: Colors.yellow[300],
                        ),
                        const Text("level 10",
                            textScaleFactor: 0.3,
                            overflow: TextOverflow
                                .ellipsis, //cuando el texto no cabe pone puntitos
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                        Container(
                          width: 100,
                          child: ClipRRect(
                              //clip reect para poner el border y dento ponemos la imagen
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                color: Colors.yellowAccent,
                              )),
                        ),
                      ],
                    ),

                    //monedas
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            //  alignment: Alignment.,
                            child: ClipRRect(
                              //clip reect para poner el border y dento ponemos la imagen
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.white38,
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      //   radius: 30,
                                      // child: Image.asset('assets/logo1.png'),
                                      backgroundImage: //NetworkImage(back_fichas1),
                                          AssetImage("assets/2logoficha.png"),
                                      radius: 20,

                                      //  borderColor: Colors.yellow,
                                    ),
                                    Text(
                                      fichasbit1.toString(),
                                      //textScaleFactor: 24,
                                      textScaleFactor: 0.4,

                                      overflow: TextOverflow
                                          .ellipsis, //cuando el texto no cabe pone puntitos
                                      style: const TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: ClipRRect(
                              //clip reect para poner el border y dento ponemos la imagen
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.white38,
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      //   radius: 30,
                                      // child: Image.asset('assets/logo1.png'),
                                      backgroundImage:
                                          AssetImage("assets/diamante1.png"),

                                      //NetworkImage(back_fichas_game),
                                      radius: 20,

                                      //  borderColor: Colors.yellow,
                                    ),
                                    Text(
                                      diamantes.toString(),
                                      //textScaleFactor: 24,
                                      textScaleFactor: 0.4,

                                      overflow: TextOverflow
                                          .ellipsis, //cuando el texto no cabe pone puntitos
                                      style: const TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
              //icono comprar mas monedas

              Icon(
                Icons.grade_sharp,
                color: Colors.yellow[400],
              ),

              const Icon(
                Icons.email,
                color: Colors.white38,
              ),
              const Spacer(),

              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    child: const Icon(Icons.qr_code,
                        color: Colors.white), // Icon(Icons.menu),
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierColor:
                            Colors.black12.withOpacity(0.6), // Background color
                        barrierDismissible: false,
                        barrierLabel: 'Dialog',
                        transitionDuration: const Duration(
                            milliseconds:
                                400), // How long it takes to popup dialog after button click
                        pageBuilder: (_, __, ___) {
                          // Makes widget fullscreen
                          return SizedBox.expand(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 9,
                                  child: SizedBox.expand(
                                      child: Container(
                                    padding: const EdgeInsets.all(40),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: const BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: ListView(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                // width: size.width * 0.85,
                                                // margin: EdgeInsets.symmetric(vertical: 30.0),
                                                // padding: EdgeInsets.symmetric(vertical: 50.0),
                                                decoration: BoxDecoration(
                                                    //  color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            110),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          color: Colors.black26,
                                                          blurRadius: 3.0,
                                                          offset: const Offset(
                                                              0.0, 5.0),
                                                          spreadRadius: 3.0)
                                                    ]),

                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: CircleAvatar(
                                                    radius: 100,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            50, 20, 200, 0.8),
                                                    child: CircleAvatar(
                                                      //   radius: 30,
                                                      // child: Image.asset('assets/logo1.png'),
                                                      backgroundImage:
                                                          NetworkImage(
                                                              _prefusers.foto),
                                                      radius: 97,

                                                      //  borderColor: Colors.yellow,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Text(
                                                        "$nombre ",
                                                        textScaleFactor: 1,
                                                        style: const TextStyle(
                                                          fontSize: 20.0,
                                                          // color: Color.fromRGBO(10, 70, 110, 1),
                                                          fontFamily: 'MyFont',
                                                        ),
                                                      ))),

                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Center(
                                                      child: cuadrado_qr())),

                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                  disabledColor: Colors.amber,
                                                  child:
                                                      const Text("Ver Perfil"),
                                                  splashColor: Colors.amber,
                                                  color: Colors.orange[300],
                                                  onPressed: () {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            'perfil_user');
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                  disabledColor:
                                                      Colors.amber[900],
                                                  child: const Text(
                                                      "¿quienes somos? "),
                                                  splashColor: Colors.amber,
                                                  color: Colors.orange[300],
                                                  onPressed: () {
                                                    print(
                                                        "ejecutar accion pendiente para ");
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                  disabledColor:
                                                      Colors.amber[900],
                                                  child: const Text(
                                                      "trabaja con nosotros "),
                                                  splashColor: Colors.amber,
                                                  color: Colors.orange[300],
                                                  onPressed: () {
                                                    print(
                                                        "ejecutar accion pendiente para trabajar y mostrar alguna pagina que guarde info o algo asi  ");
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                  disabledColor:
                                                      Colors.amber[900],
                                                  child: const Text(
                                                      "Cerrar Sesion "),
                                                  splashColor: Colors.amber,
                                                  color: Colors.orange[300],
                                                  onPressed: () async {
                                                    _prefusers.token = "";
                                                    // _pref_user.token_notifi = "";
                                                    _prefusers.nombre = "";
                                                    _prefusers.foto = "";
                                                    _prefusers.direccion = "";
                                                    _prefusers.telefono = "";
                                                    _prefusers.latitud = 0;
                                                    _prefusers.longitud = 0;
                                                    //cerrrar cesion
                                                    final provider_authgoogle =
                                                        Provider.of<
                                                                GoogleSingInProvider>(
                                                            context,
                                                            listen: false);
                                                    provider_authgoogle
                                                        .longout_cerrar();

                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context, 'login');
                                                  },
                                                ),
                                              ),

                                              /*ElevatedButton(
                                                  onPressed: () {
                                                    _pref_user.foto = "";
                                                    _pref_user.token = "";
                                                    _pref_user.token_notifi = "";
                                                    _pref_user.nombre = "";

                                                    Navigator.pushReplacementNamed(
                                                        context, 'login');
                                                  },
                                                  child: Text(
                                                    'Cerrar cesion',
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                                */
                                              /* Center(
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          //borrar
                                                          final pref =
                                                              new PreferenciasUsuario();
                                                          // print(pref.token); //imprime el tokken cuando se obtiene
                                                          String nombre = '';
                                                          pref.token = "";
                                                          Navigator.pushReplacementNamed(
                                                              context, 'login');
                                                        },
                                                        child: Text("cerrar cesion "))),*/

                                              // FlutterLogo(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )), //aqui mostraba el logo de flutter
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox.expand(
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'return',
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
                    }),
              ),
            ],
          ),
          //titulo del jeugo

          //reglas list
        ],
      ),
    );
  }

  void _cargarsharedpreferencesweb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getBool('auth');
      nombre = prefs.getString("nombreweb")!;
      foto_c = prefs.getString("fotoweb")!;
    });
    // prefs.getBool('auth');
    //nombre = prefs.getString("nombreweb")!;
    // foto_c = prefs.getString("fotoweb")!;
    //fichasbit1 = prefs.getDouble("fichas")!;
    // diamantes = prefs.getDouble("diamantes")!;
    var _uid = prefs.getString("tokenweb")!;

    //--
    var fichasfire = 0.0;
    var diamantesfire = 0.0;

    // fichasbit1 = prefs.getString("fichas")! as double;
    // diamantes = prefs.getString("diamantes")! as double;
    //busquemos el dinero que tengo realmente
    print(nombre + "SHAREDWEB");
    var registro_compra1 = FirebaseFirestore.instance.collection('Coinbase');

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
        if (element.exists) {
          GuardarCompra _snap_mesa = GuardarCompra.fromdocument(element);

          fichasfire += _snap_mesa.fichas; //lo llogre 2800
          if (fichasbit1 != fichasfire) {
            setState(() {
              fichasbit1 = fichasfire;
            });
          }
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
        if (element.exists) {
          GuardarCompra _snap_mesa = GuardarCompra.fromdocument(element);

          diamantesfire += _snap_mesa.fichas; //lo llogre 2800
          if (diamantes != diamantesfire) {
            setState(() {
              diamantes = diamantesfire;
            });
          }
        }

        //  diamantes += _snap_mesa.diamantes;
        //funciona pero aun tiene un error  24/12/21
        //al recargar se actualiza los valores y no cambia no puedo entregar tanto dinero
      });
    });

    // setState(() {});
  }
}
