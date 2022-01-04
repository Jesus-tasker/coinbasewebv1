import 'package:cache_audio_player/cache_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/audioplayer/audiov3.dart';
import 'package:criptodadosweb/pagues/models/juegodados/guardar_compra.dart';
import 'package:criptodadosweb/pagues/pagos_criptos/pagarcriptos.dart';
import 'package:criptodadosweb/pagues/pagos_criptos/reglas_ui.dart';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:criptodadosweb/utils/utils.dart';
import 'package:criptodadosweb/utils/utils_textos.dart';
import 'package:criptodadosweb/widgets/cardswupernullsaefty.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'criptogame/v2/provider1_ibuscarpartida.dart';
import 'login/gogogle_sing_provider.dart';
import 'models/materias_elegir.dart';
import 'models/pagos_bakcend/comprasmodel.dart';

class Menuinicio extends StatefulWidget {
  const Menuinicio({Key? key}) : super(key: key);

  @override
  MenuinicioState createState() => MenuinicioState();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(Menuinicio());
  });
}

String nombre = "";
double fichasbit1 = 0;
double diamantes = 0;

class MenuinicioState extends State<Menuinicio> {
  String foto_c =
      "https://conceptodefinicion.de/wp-content/uploads/2015/03/hombre.jpg";
  String background_fichas =
      "https://i.pinimg.com/originals/ee/f6/5e/eef65ee1a4e6a9a9036810fe1ddf9ba9.jpg";
  String back_fichas1 =
      "https://e7.pngegg.com/pngimages/260/681/png-clipart-logo-event-tickets-very-important-person-game-vip-logo-game-logo-thumbnail.png";

  String back_fichas_game =
      "https://images.vexels.com/media/users/3/151686/isolated/preview/45130c6d03b2256e6615f2a696195f41-icone-plano-de-gema-de-diamante.png";

  Color color_principal = Color.fromARGB(58, 83, 10, 88); //violeta claro
  // Color color_principal = Color.fromRGBO(10, 100, 10, 0.1);
  // Color color_principal = Color.fromRGBO(10, 100, 10, 0.1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        padding: EdgeInsets.all(10),
        child: Expanded(
            child: Stack(
          children: <Widget>[
            //  _crearFondo(context),
            //_crear_fondo_fichas(context),
            // Expanded(child: Container(color:Colors.black),
            Container(color: Colors.black),

            Column(
              children: [
                _0_monedas_user(context),
                _00_reglas(context),
              ],
            ),
            // _00_reglas(context), lo puse en monedas user

            _1_opciones_partida(context),

            _2_opciones_regalos_y_ventas(context),

            //   _listaopciones(context),
          ],
        )),
      ),
    );
  }

  Widget _crear_fondo_fichas(BuildContext context) {
    //opciones de juego
    //

    return Container(
      child: Row(
        children: [
          //1imagen promocional
          Container(
            padding: EdgeInsets.only(top: 100),
            height: 300,
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.contain,
              child: CircleAvatar(
                //   radius: 30,
                // child: Image.asset('assets/logo1.png'),
                backgroundImage: NetworkImage(background_fichas),
                radius: 150,

                //  borderColor: Colors.yellow,
              ),
            ),
          ),
          //opciones de juegos
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 1,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(10, 50, 1, 1),
        // Colors.black54,
        // Colors.yellow.shade100,
        // Colors.black87,
        //Colors.white38,
        //Colors.yellow.shade100,

        //  Color.fromRGBO(90, 70, 178, 1), //original 1
        // Color.fromRGBO(10, 30, 60, 1), //auzl oscuro violeta original 2
        //Color.fromRGBO(10, 100, 1, 0.5),
        // Colors.black,
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        /* Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              //  Icon(Icons.person_add, color: Colors.white, size: 100.0),
              //SizedBox(height: 10.0, width: double.infinity),
              // Text('play!',style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )*/
      ],
    );
  }

  final _prefusers = PreferenciasUsuario();

  ///--
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
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla

    return Container(
      padding: EdgeInsets.only(top: 10),
      color: Color.fromARGB(255, 54, 1,
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
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Text(" "),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromARGB(255, 211, 201,
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
                          style: TextStyle(
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
                        Text("level 10",
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
                                    CircleAvatar(
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
                                      style: TextStyle(
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
                                    CircleAvatar(
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
                                      style: TextStyle(
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

              Icon(
                Icons.email,
                color: Colors.white38,
              ),
              Spacer(),

              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    child: Icon(Icons.qr_code,
                        color: Colors.white), // Icon(Icons.menu),
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierColor:
                            Colors.black12.withOpacity(0.6), // Background color
                        barrierDismissible: false,
                        barrierLabel: 'Dialog',
                        transitionDuration: Duration(
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
                                    padding: EdgeInsets.all(40),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(
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
                                                          offset:
                                                              Offset(0.0, 5.0),
                                                          spreadRadius: 3.0)
                                                    ]),

                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: CircleAvatar(
                                                    radius: 100,
                                                    backgroundColor:
                                                        Color.fromRGBO(
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
                                                      padding: EdgeInsets.only(
                                                          top: 15),
                                                      child: Text(
                                                        "$nombre ",
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          // color: Color.fromRGBO(10, 70, 110, 1),
                                                          fontFamily: 'MyFont',
                                                        ),
                                                      ))),

                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Center(
                                                      child: cuadrado_qr())),

                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                  disabledColor: Colors.amber,
                                                  child: Text("Ver Perfil"),
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
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                  disabledColor:
                                                      Colors.amber[900],
                                                  child:
                                                      Text("¿quienes somos? "),
                                                  splashColor: Colors.amber,
                                                  color: Colors.orange[300],
                                                  onPressed: () {
                                                    print(
                                                        "ejecutar accion pendiente para ");
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                  disabledColor:
                                                      Colors.amber[900],
                                                  child: Text(
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
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(30.0)),
                                                  disabledColor:
                                                      Colors.amber[900],
                                                  child: Text("Cerrar Sesion "),
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
                                      child: Text(
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

  _listaopciones(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Container(
                  //alignment: AlignTransition,
                  child: Text(
                    'Play options ',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    textScaleFactor: 1.4,
                  ),
                ),

                SizedBox(height: 60.0),
                // _crearEmail(bloc),
                _1_jugar_demo(context),
                SizedBox(height: 30.0),
                //SizedBox(height: 30.0),
                // _crearBoton(bloc)
              ],
            ),
          ),
          FlatButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: Center(
                child: Text('ya tienes cuenta?, inicia cesion',
                    textScaleFactor: 1, style: TextStyle(color: Colors.white)),
              )),
          SizedBox(height: 100.0),
          Text("  "),
        ],
      ),
    );
  }

////--
  Widget _00_reglas(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("verreglas");
        Ver_Opciones_listas(context, 1);
      },
      child: Container(
        // padding: EdgeInsets.only(top: 100, left: 100),
        //  height: 100,
        alignment: Alignment.centerRight,
        // color: Colors.white38,
        child: ClipRRect(
          //clip reect para poner el border y dento ponemos la imagen
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Icon(Icons.casino, color: Colors.white),
              util_texts_white_2_agregattamano("DadosCripto", 0.4),
              Icon(Icons.casino, color: Colors.white),
              Spacer(),
              Text("Ruler list!",
                  textScaleFactor: 0.4,
                  style: TextStyle(
                      color: Colors.white, decoration: TextDecoration.none)),
              Icon(Icons.info_outline_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  ///--
  /////no sirvio
  Widget _1_jugar_demo(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        disabledColor: Colors.amber,
        child: Text(
          "Training",
          textScaleFactor: 1,
        ),
        splashColor: Colors.amber,
        color: Colors.pink[200],
        //icon: Icon(Icons.save),
        onPressed: () async {
          new Container(
            child: CircularProgressIndicator(
              //color: Colors.accents,
              valueColor: AlwaysStoppedAnimation(Colors.green),
            ),
          );
        },
      ),
    );
  }

//mejor opcion
  Widget _1_opciones_partida(BuildContext context) {
    //practica Training
    //pay for chips /comprar fichas
    // play online
    String foto1_training = "assets/foto1_training.png";
    //  "https://vegas-x.net/wp-content/uploads/2019/02/unnamed-1.png";
    String foto1v1 = "assets/1v1.png";
    //  "http://www.zontikgames.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/b/a/backgammon-precision-dice-black_primary.jpg";
    String fotoprofesional = "assets/profesionals.png";
    // "https://c4.wallpaperflare.com/wallpaper/1007/106/501/3d-dice-04-wallpaper-preview.jpg";
    final List<Materias> _materiaslist = [];
    _materiaslist.add(Materias(
        idMaterias: "00",
        materia: "Training",
        descripcion: "play training",
        duracion: "duracion",
        valor: 100,
        disponible: false,
        fotoUrlLogo: foto1_training,
        fotoUrlFondo: foto1_training,
        color: "color"));
    //
    _materiaslist.add(Materias(
        idMaterias: "01",
        materia: "1 VS 1 game",
        descripcion: "friendly game",
        duracion: "duracion",
        valor: 100,
        disponible: false,
        fotoUrlLogo: foto1v1,
        fotoUrlFondo: foto1v1,
        color: "color"));
    //
    _materiaslist.add(Materias(
        idMaterias: "02",
        materia: "Profesional",
        descripcion: "all or nothing",
        duracion: "duracion",
        valor: 100,
        disponible: false,
        fotoUrlLogo: fotoprofesional,
        fotoUrlFondo: fotoprofesional,
        color: "color"));
    //final _screensize =MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla

    /*  return Container(
        alignment: Alignment.center,
        child: Card_swipeer(materiaslist: _materiaslist));*/

    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    //1/2
    Widget _Juegos_selec = Container(
      /*  decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),*/
      alignment: Alignment.center,
      //CONTENEDOR CON EL SWIPE <..> PARA MOVERSE
      //le decimos el tamaño que debe tener y donde sacar las imagens
      width: double.infinity, //usar tood el ancho
      padding: EdgeInsets.only(top: 10), //pading superos
      //width: _screensize.width * 0.7 , //que el tamaño sea el 70% de ancho en la pantalla
      height: _screensize.height * 0.65, //la mitad del dispitivo

      child: Swiper(
        //tabulador paginador mejor que paper adapter
        layout:
            SwiperLayout.STACK, //aqui pasamos el tipo de paginacion el efecto
        itemHeight: _screensize.height,
        itemWidth: 300, // _screensize.height * 0.3,
        itemBuilder: (BuildContext context, int index) {
          //hace el ciclo de los elementos como peliuclas el ciclo for
          return Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(width: 1, color: color_principal)),
            child: Hero(
              tag: _materiaslist[index].idMaterias,
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
                      //aqui empieza el juego supongamos que es con 1 jugador
                      //buscar o crear una partida
                      dialog_buscandopartida(context, 1, 500);
                      //1 BUSCANDO PARTIDA
                      //ENLISTARSE EN UNA LISTA USUARIOS
                      //// STATUS :ON
                      //12:01-timestamp
                      //yase registro el usuario como disponible , luego empieza una segunda query
                      //2. get  5 usuarios por partida .
                      //obtener los ultimos 5 usuarios donde status y tiemestamp son similares
                      //enviarles una solicitud con el uid de la mesa si la aceptan pasan a esa mesa
                      //3. si la aceptan cambia su estado a of y son enviados a la plantilla con el numero de la mesa

                      /* Navigator.pushNamed(context, "playdados",
                          arguments: materiaslist[index].idMaterias.toString());*/
                      //PROVIDERPARTIDA0

                      //esta la estaba usando
                      /*   Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Jugardados("partidan")),
                        (r) => false,
                      );*/
                      //  Navigator.pushNamed(context, "detalle",
                      //    arguments: materiaslist[index]);
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            child: Image.network(
                              _materiaslist[index].fotoUrlFondo,
                            ),
                            /*
                            //original par app
                             FadeInImage(
                              image: NetworkImage(
                                _materiaslist[index].fotoUrlFondo,
                                // _materiaslist[index].getbackgroundimage(),//original funicona en app
                              ), // peliculas_list[index].getposterimage()
                             
                              placeholder:
                                  const AssetImage('assets/no-image.png'),
                              fit: BoxFit
                                  .cover, //reparo el error del controno medio ciruclar
                            ), */
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 50,
                              width: _screensize.width - 20,
                              alignment: Alignment.topCenter,
                              color: Colors.white38,
                              child: ClipRRect(
                                //clip reect para poner el border y dento ponemos la imagen
                                borderRadius: BorderRadius.circular(20),
                                child: Text(
                                  _materiaslist[index].materia,
                                  //textScaleFactor: 24,
                                  textScaleFactor: 2.5,

                                  overflow: TextOverflow
                                      .ellipsis, //cuando el texto no cabe pone puntitos
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            //  height: 100,
                            alignment: Alignment.bottomCenter,
                            // color: Colors.white38,
                            child: ClipRRect(
                              //clip reect para poner el border y dento ponemos la imagen
                              borderRadius: BorderRadius.circular(20),
                              child: Text(
                                _materiaslist[index].descripcion,
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
                  )),
            ),
          );
        },
        itemCount: _materiaslist.length, //3,
        //pagination:    new SwiperPagination(), //viene por defecto es para mostrar los puntitos de abajo para paginar
        control: const SwiperControl(
          iconNext: Icons.arrow_forward_ios,
        ), //viene por defecto para mover hacia los ladors
      ),
    );
    //2/2
    //return Container(alignment: Alignment.center, child: _Juegos_selec);
    return Container(
        alignment: Alignment.center,
        child: Card_swipeer_nullsaefty(materiaslist: _materiaslist));
  }

//--------22222
  Widget _2_opciones_regalos_y_ventas(BuildContext context) {
    var colors1_fondo_btns = Colors.purple[800];
    String foto_regalo =
        "https://i.pinimg.com/736x/b2/de/48/b2de4818654a9a33b1140da8ffb4eac5.jpg";
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.bottomLeft,
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.yellow[300],
                  radius: 40,
                  child: CircleAvatar(
                    backgroundColor: colors1_fondo_btns,
                    child: Icon(Icons.add_shopping_cart_rounded),
                    radius: 38,
                  ),
                ),
                onTap: () {
                  _compras0_seleccionarcompra(context, 1);
                },
              ),
            ),
            //
            Container(
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.yellow[300],
                  radius: 40,
                  child: CircleAvatar(
                    backgroundColor: colors1_fondo_btns,
                    child: Icon(Icons.person_add),
                    radius: 38,
                  ),
                ),
                onTap: () {
                  //
                  print("nuevo usuario");
                  //         sonido1();
                  playLocalAsset(); //funciona con mp3 en internet
                  // playLocalAsset2();
                  /*  var audioplayer = AudioPlayerState;
                  // var audioplayer1 = AudioPlayer();
                  final audio = AudioCache();
                  // behavior_subject_mixin: null
                  audio.play("yes.mp3");
                  print("object");
                  AudioCache player = new AudioCache();
                  const alarmAudioPath = "yes.mp3";
                  player.play(alarmAudioPath);*/
                },
              ),
            ),
            //
            Container(
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.yellow[300],
                  radius: 40,
                  child: CircleAvatar(
                    backgroundColor: colors1_fondo_btns,
                    child: Icon(Icons.star),
                    radius: 38,
                  ),
                ),
                onTap: () {
                  //
                  print("Premios  ");
                },
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 10),
              child: GestureDetector(
                child: Stack(
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Color.fromARGB(244, 213, 248, 17),
                        child: CircleAvatar(
                          //   radius: 30,
                          // child: Image.asset('assets/logo1.png'),
                          backgroundImage: NetworkImage(foto_regalo),
                          radius: 35,

                          //  borderColor: Colors.yellow,
                        ),
                        /* CircleAvatar(
                          // child: Image.asset('assets/logo1.png'),
                          backgroundImage: const NetworkImage(
                              "https://i.pinimg.com/736x/b2/de/48/b2de4818654a9a33b1140da8ffb4eac5.jpg"),
                          //backgroundImage: Image.network("https://i.pinimg.com/736x/b2/de/48/b2de4818654a9a33b1140da8ffb4eac5.jpg").image,
                          radius: 45,

                          // radius: 50,

                          //  borderColor: Colors.yellow,
                        ),*/
                      ),
                    ),
                    Text("3:30",
                        textScaleFactor: 0.3,
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none)),
                  ],
                ),
                onTap: () {
                  //
                  print("canjear premio ");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //-aqui muestor el opciones diamantes o ficahs negras
  _compras0_seleccionarcompra(BuildContext context, int i) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(
          milliseconds:
              400), // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // Makes widget fullscreen
        return SizedBox.expand(
          child: Column(
            children: <Widget>[
              /*Expanded(
                flex: 5,
                child: SizedBox.expand(
                    child: _compras1_seleccionarcompra(
                        context)), //aqui mostraba el logo de flutter
              ),*/
              //seleccionamos fichas negras
              Spacer(),
              util_texts_white_2_agregattamano("selec coin", 1), Spacer(),

              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      //style: ButtonStyle(backgroundColor: ),

                      onPressed: () => _compras001_cantidades(context, 1),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage("assets/2logoficha.png"),
                            ),
                            Text(
                              ' Darckchips',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white38,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      //style: ButtonStyle(backgroundColor: ),

                      onPressed: () => _compras001_cantidades(context, 2),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage("assets/diamante1.png"),
                            ),
                            Text(
                              ' DiamondCHips',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white38,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),

              Spacer(),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'cancel',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //-cantidades ej 100 3000 4000
  _compras001_cantidades(BuildContext context, int i) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(
          milliseconds:
              400), // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // Makes widget fullscreen
        return SizedBox.expand(
          child: Column(
            children: <Widget>[
              //1-titulo
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: Container(
                      alignment: Alignment.center,
                      child: util_texts_white_2_agregattamano("selec", 0.7)),
                ), //aqui mostraba el logo de flutter
              ),
              //2-lista para seleccionar
              Expanded(
                flex: 7,
                child: SizedBox.expand(
                  child: _compras003_selecciona_unidades(context, i),
                ), //aqui mostraba el logo de flutter
              ),
              //seleccionamos fichas negras

              // util_texts_white_2_agregattamano("selec coin", 1), Spacer(),
              // Spacer(),
              Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'cancel',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //-opciones de compra
  _compras003_selecciona_unidades(BuildContext context, int monedaselec) {
    //
    print("opciones de compra cript ");
    //  Navigator.pushNamed(context, 'coinbase');
    //Navigator.pushReplacementNamed(context, 'coinbase');
    String anunciofichas = "Using for friendly game";

    final _screensize = MediaQuery.of(context).size;
    final double itemHeight = (_screensize.height - kToolbarHeight - 24) / 2;
    final double itemWidth = _screensize.width / 2;
    final double altov2 = _screensize.height * 0.7;

    List<Comprasmodel> listamodels = [
      new Comprasmodel(
          moneda_name: "Darckchip",
          rutaimagen: "assets/2logoficha.png",
          cantidad: 700,
          prefio: "1 usd"),
      new Comprasmodel(
          moneda_name: "Darckchip",
          rutaimagen: "assets/2logoficha.png",
          cantidad: 5000,
          prefio: "5 usd"),
      new Comprasmodel(
          moneda_name: "Darckchip",
          rutaimagen: "assets/2logoficha.png",
          cantidad: 15000,
          prefio: "10 usd"),
      new Comprasmodel(
          moneda_name: "Darckchip",
          rutaimagen: "assets/2logoficha.png",
          cantidad: 30000,
          prefio: "20 usd"),
      new Comprasmodel(
          moneda_name: "Darckchip",
          rutaimagen: "assets/2logoficha.png",
          cantidad: 100000,
          prefio: "50 usd")
    ];
    List<Comprasmodel> listamodel2 = [
      new Comprasmodel(
          moneda_name: "Diamond token",
          rutaimagen: "assets/diamante1.png",
          cantidad: 1,
          prefio: "1 usd"),
      new Comprasmodel(
          moneda_name: "Diamond token",
          rutaimagen: "assets/diamante1.png",
          cantidad: 12,
          prefio: "10 usd"),
      new Comprasmodel(
          moneda_name: "Diamond token",
          rutaimagen: "assets/diamante1.png",
          cantidad: 25,
          prefio: "20 usd"),
      new Comprasmodel(
          moneda_name: "Diamond token",
          rutaimagen: "assets/diamante1.png",
          cantidad: 60,
          prefio: "50 usd")
    ];
    if (monedaselec == 2) {
      listamodels = listamodel2;
      anunciofichas = " used for contract exchanges and wallets";
    }

    return GridView.count(
      crossAxisCount: 1,
      scrollDirection: Axis.vertical,
      childAspectRatio: 1.0,
      padding: const EdgeInsets.all(4.0),
      //childAspectRatio: (itemWidth / altov2), // (itemWidth / 370),
      mainAxisSpacing: 5.0, //espacios  arriba y abajo
      crossAxisSpacing: 5.0, //espacio  laterales
      shrinkWrap: true,
      physics: ScrollPhysics(),

      children: listamodels.map((document) {
        var color_estado_autorizar = Colors.yellow[200];
        var estado_autorizado = "AUTORIZED";
        bool verwidget = false;

        String direcciondepago = "pagar a esta cuenta ";

        final _tarjeta3_contenido = Container(
          //  padding: const EdgeInsets.only(left: 10),
          width: double.infinity,

          height: _screensize.height * 0.3,
          //child: Text(document['buyOrder']),
          //expanded

          //  padding: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () => {
              // Navigator.pushNamed(context, "");
              //  Navigator.pushReplacementNamed(context,'Pagarcriptos'),
              // pagarcriptos(document),
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => pagarcriptos(document)),
                (r) => false,
              ) //.then((value) => Navigator.pop(context),),
            },
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(document.rutaimagen),
                      ),
                      Text(
                        document.moneda_name,
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  //precio y ganancia
                  Row(
                    children: [
                      Icon(Icons.monetization_on),
                      Text(
                        document.prefio,
                        style: TextStyle(fontSize: 40),
                      ),
                      Spacer(),
                      Icon(Icons.add),
                      Text(
                        document.cantidad.toString(),
                        style: TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                  Spacer(),
                  util_texts_white_2_agregattamano(anunciofichas, 1),
                  Spacer(),
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
          ),
        );

        final tarjeta4_bordes = Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: GestureDetector(
            child: _tarjeta3_contenido,
            onTap: () {
              print(document.moneda_name);
              setState(() {
                // mostrardialogbuttonshet(context, criptoselected_name);
                Navigator.pop(context);
              });
            },
          ), //tr 3
        );
        return Container(height: 160, child: tarjeta4_bordes);
        /*GestureDetector(
                  child:tarjeta ,
                  onTap: ,
                );*/

        //
      }).toList(),
    );
  }

  void _cargarsharedpreferencesweb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('auth');
    nombre = prefs.getString("nombreweb")!;
    foto_c = prefs.getString("fotoweb")!;
    //fichasbit1 = prefs.getDouble("fichas")!;
    // diamantes = prefs.getDouble("diamantes")!;
    var _uid = prefs.getString("tokenweb")!;

    //--
    var fichasfire = 0.0;
    var diamantesfire = 0.0;

    // fichasbit1 = prefs.getString("fichas")! as double;
    // diamantes = prefs.getString("diamantes")! as double;
    //busquemos el dinero que tengo realmente
    print(nombre);
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

    // setState(() {});
  }

//---------333  reglasui

}
