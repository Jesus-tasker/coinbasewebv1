import 'package:criptodadosweb/utils/utils_textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

//base vacia para su cambios
class Jugardados extends StatefulWidget {
  Jugardados(String s, {Key? key}) : super(key: key);

  @override
  _JugardadosState createState() => _JugardadosState();
}

class _JugardadosState extends State<Jugardados> {
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
                            "partida",
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

  _3_lista_jugadores(BuildContext context) {
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
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
                              _jugador1(context, "juan", 5000, 100),
                              util_texts("340"),
                            ],
                          ),
                        ), //contrincante1
                        Container(
                          //padding: EdgeInsets.only(bottom: 200),

                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(top: 400),
                          child: Column(
                            children: [
                              _jugador1(context, "erica", 5000, 100),
                              util_texts("340"),
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
                              _jugador1(context, "juan", 5000, 100),
                              util_texts("340"),
                            ],
                          ),
                        ), //contrincante1
                        Container(
                          //padding: EdgeInsets.only(bottom: 200),

                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(top: 400),
                          child: Column(
                            children: [
                              _jugador1(context, "erica", 5000, 100),
                              util_texts("340"),
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

  Widget _jugador1(
      BuildContext context, String nombre, int fichas, int apuesta_actual) {
    ///
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    //lo puse primero para llamarlo pero empezamos con widget 2
    ///
    Widget widget3_datosjugador1 = Container(
      height: 40,
      width: 100,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(nombre,
                          // textScaleFactor: 10,
                          style: TextStyle(
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
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );

    Widget widget2_foto = Container(
      //alignment: Alignment.topCenter,
      height: 100,
      width: 100,
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

            //circulo de regalos
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  "https://banner2.cleanpng.com/20180506/kce/kisspng-gift-computer-icons-santa-claus-5aef2ed5403e26.1458458615256245332631.jpg"),
            )
            //mostrardados
            /* Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.bottomRight,
                child: widget4_dados),*/
          ],
        ),
      ),
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

    return widget2_foto;
  }

  Widget _4_jugadorprincipal(BuildContext context, String nombre, int fichas) {
    Widget widget3_datosjugador1 = Container(
      height: 40,
      width: 100,
      child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1, color: color_principal)),
          child: Container(
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(nombre,
                          // textScaleFactor: 10,
                          style: TextStyle(
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
            blurRadius: 1.0,
            offset: Offset(0, 5),
            spreadRadius: 0.4,
          ),
        ],
        borderRadius: BorderRadius.circular(80),
      ),
    );

    return Container(
      alignment: Alignment.bottomCenter,
      height: 150,
      width: 150,
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
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.freeimages.com/images/large-previews/4dc/free-casino-table-cloth-texture-1637741.jpg"), // peliculas_list[index].getposterimage()
              ),
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
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  "https://banner2.cleanpng.com/20180506/kce/kisspng-gift-computer-icons-santa-claus-5aef2ed5403e26.1458458615256245332631.jpg"),
            )
            //mostrardados
            /* Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.bottomRight,
                child: widget4_dados),*/
          ],
        ),
      ),
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
    Widget _raisetn = Container(
      height: 40,
      width: 100,
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
    Widget _check2b = Container(
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

  // SI LA ORIENTACION horizontal
}
