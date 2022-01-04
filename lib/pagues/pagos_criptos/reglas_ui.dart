
import 'package:criptodadosweb/pagues/models/materias_elegir.dart';
import 'package:criptodadosweb/pagues/youtube%20mvc/youtube_v1.dart';
import 'package:criptodadosweb/utils/utils_textos.dart';
import 'package:flutter/material.dart';

List<Materias> _materiaslist1_videos = []; //videos
//-cantidades ej 100 3000 4000
Ver_Opciones_listas(BuildContext context, int i) {
  _cargar_lista_productos_grind();

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
            //  util_texts_white_2_agregattamano("Rules!", 0.5), Spacer(),
            //video
            Expanded(
              flex: 3,
              child: SizedBox.expand(
                  child: YoutubePlayerDemoApp(_materiaslist1_videos[
                      0])), //aqui mostraba el logo de flutter
            ),
            //usado para el list view con las opciones
            Expanded(
              flex: 1,
              child: SizedBox.expand(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    //style: ButtonStyle(backgroundColor: ),

                    onPressed: () =>
                        Ver_Opciones_listas2(context, 1, '1. How play?'),
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
                            '1. How play?',
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

                    onPressed: () =>
                        Ver_Opciones_listas2(context, 2, '2. Number Winners'),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage("assets/diamante1.png"),
                          ),
                          Text(
                            '2. Number Winners',
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

                    onPressed: () =>
                        Ver_Opciones_listas2(context, 3, '3.tokkens money'),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage("assets/diamante1.png"),
                          ),
                          Text(
                            '3.tokkens money',
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

                    onPressed: () => Ver_Opciones_listas2(
                        context, 5, "5.NFT Gifts and Reward"),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage("assets/diamante1.png"),
                          ),
                          Text(
                            '4.NFT Gifts and Reward',
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

_cargar_lista_productos_grind() {
  _materiaslist1_videos.add(new Materias(
      idMaterias: '10',
      materia: "mi cabello",
      descripcion: "Productos  capilares dama",
      duracion: "5 horas",
      valor: 20,
      disponible: true,
      fotoUrlLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhkKCv6l9EYsJj1q5-6glMTx1tcKTNHztlYg&usqp=CAU",
      fotoUrlFondo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhkKCv6l9EYsJj1q5-6glMTx1tcKTNHztlYg&usqp=CAU",
      color: ""));
  _materiaslist1_videos.add(new Materias(
      idMaterias: '11',
      materia: "Cuidada tu piel",
      descripcion: "crea ",
      duracion: "5 horas",
      valor: 20,
      disponible: true,
      fotoUrlLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROymm5_zHx01_j8hOSavUgaxq8xz4B5IILiJ39EvjJweE83d-gBjEM-YspUJov9ylNHPM&usqp=CAU",
      fotoUrlFondo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROymm5_zHx01_j8hOSavUgaxq8xz4B5IILiJ39EvjJweE83d-gBjEM-YspUJov9ylNHPM&usqp=CAU",
      color: ""));
  _materiaslist1_videos.add(new Materias(
      idMaterias: '12',
      materia: "Productos barber",
      descripcion: "crea juegos con unity y c#",
      duracion: "5 horas",
      valor: 20,
      disponible: true,
      fotoUrlLogo: "https://www.3claveles.com/img/cms/barberia2.jpg",
      fotoUrlFondo: "https://www.3claveles.com/img/cms/barberia2.jpg",
      color: ""));

  _materiaslist1_videos.add(new Materias(
      idMaterias: '13',
      materia: "Tintes y color",
      descripcion: "crea juegos con unity y c#",
      duracion: "5 horas",
      valor: 20,
      disponible: true,
      fotoUrlLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWm3rg8ZE5JmiIRXAVdYbDwdrQeJXhUm1IRXkvPpyRjhJJVaewoVJDWWBNR9m1RpRVO8M&usqp=CAU",
      fotoUrlFondo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWm3rg8ZE5JmiIRXAVdYbDwdrQeJXhUm1IRXkvPpyRjhJJVaewoVJDWWBNR9m1RpRVO8M&usqp=CAU",
      color: ""));
  _materiaslist1_videos.add(new Materias(
      idMaterias: '5',
      materia: "Maquinas",
      descripcion: "crea juegos con unity y c#",
      duracion: "5 horas",
      valor: 20,
      disponible: true,
      fotoUrlLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC7W1Hr4ylvBkxBmGxWhIL-mwR4Ytr2gsbaQ&usqp=CAU",
      fotoUrlFondo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC7W1Hr4ylvBkxBmGxWhIL-mwR4Ytr2gsbaQ&usqp=CAU",
      color: ""));
  _materiaslist1_videos.add(new Materias(
      idMaterias: '5',
      materia: "Uñas y pestañas",
      descripcion: "crea juegos con unity y c#",
      duracion: "5 horas",
      valor: 20,
      disponible: true,
      fotoUrlLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF467Z0o8Om_8YFe8GsT_1LP93U0nselDNdQ&usqp=CAU",
      fotoUrlFondo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF467Z0o8Om_8YFe8GsT_1LP93U0nselDNdQ&usqp=CAU",
      color: ""));
}

Ver_Opciones_listas2(BuildContext context, int i, String titulo) {
  var widgetselec = _1leerreglas(context, 1);
  if (i == 1) {
    widgetselec = _1leerreglas(context, 1);
  }
  if (i == 2) {
    widgetselec = _2_numberwinners(context, i);
  }
  if (i == 3) {
    widgetselec = _3_tokkens_use(context, i);
  }
  if (i == 4) {
    widgetselec = _4_NFTandgiff_rewards(context, i);
  }

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
                    child: util_texts_white_2_agregattamano(titulo, 0.7)),
              ), //aqui mostraba el logo de flutter
            ),
            //2-lista para seleccionar
            Expanded(
              flex: 7,
              child: SizedBox.expand(
                child: widgetselec,
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

//1 lista de como se jeuga falta las imagenes
_1leerreglas(BuildContext context, int i) {
  String rule1 = "Rule 1";
  String rule2 = "Rule 2";
  String rule3 = "Rule 3";
  String rule4 = "Rule 4";
  String rule5 = "Rule 5";
  String rule6 = "Rule 6";

  String textor1 =
      "game using four players,two dice for each player, maximum five dice on the table";
  //cuatro jugadores, dos dados por jugador ,maximo cinco dados en la mesa
  String textor2 =
      "The first to add twenty-one wins,otherwise the winners will share the winnings, see number winners  in list rules";
  //gana el primero en sumar ventiuno,  de lo contrario los nuemeros ganadores se repartiran las ganancias
  String textor3 =
      "each player has 2 dice, these appear after having bet and thrown";
  //cada jugador tiene 2 dados, estos aparecen despues de haber apostado y lanzado
  String textor4 = "on your turn your dice will be shown";
  //en tu turno se mostraran tus dados
  String textor5 =
      "Buttons: you will use 3 buttons to play, check to accept, raised to increase the bet and fold to withdraw from the table";
  String textor6 = "";

  return Container(
    child: ListView(
      children: [
        //1
        util_texts_white_2_agregattamano(rule1, 0.7),

        util_texts_white_3_texto_extenso(textor1, 0.4),
        //2
        util_texts_white_2_agregattamano(rule2, 0.7),

        util_texts_white_3_texto_extenso(textor2, 0.4),
        //3
        util_texts_white_2_agregattamano(rule3, 0.7),

        util_texts_white_3_texto_extenso(textor3, 0.4),
        //4
        util_texts_white_2_agregattamano(rule4, 0.7),

        util_texts_white_3_texto_extenso(textor4, 0.4),
        //5
        util_texts_white_2_agregattamano(rule5, 0.7),

        util_texts_white_3_texto_extenso(textor5, 0.4),

//
      ],
    ),
  );
/*  return showGeneralDialog(
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
                    child: util_texts_white_2_agregattamano("Rulers", 0.7)),
              ), //aqui mostraba el logo de flutter
            ),
            //2-lista para seleccionar
            Expanded(
              flex: 7,
              child: SizedBox.expand(
                child: formatoreglas,
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
*/
}

_2_numberwinners(BuildContext context, int i) {
  String rule0 = "Numbers winners";
  String rule1 = "Winner 1 player ";
  String rule2 = "Winner more 2 players";
  String rule3 = "All lost ";
  //
  String texto_001 = " sum 21 like ";
  String textor1 =
      "The first to add twenty-one wins with his own dice and the dice on the table are three on the table or five";
  String textor2 =
      "if two or more players have equal hands, the money won will be shared";
  //si dos jugadores o mas tienen manos iguales se repartiran el dinero ganado
  String textor3 = "If no one got winning numbers, the winnings will be lost";
  String textor4 = "on your turn your dice will be shown";
  //en tu turno se mostraran tus dados
  String textor5 =
      "Buttons: you will use 3 buttons to play, check to accept, raised to increase the bet and fold to withdraw from the table";
  String textor6 = "";

  return Container(
    child: ListView(
      children: [
        //-----------
        util_texts_white_2_agregattamano(rule0, 0.7),
        Spacer(),
        util_texts_white_3_texto_extenso("sum 21 like:", 0.4),
        util_texts_white_3_texto_extenso("player win 1", 0.4),

        Row(
          children: [_dado1_mesa(5), _dado1_mesa(4)],
        ),
        util_texts_white_3_texto_extenso("table 3 dados ", 0.4),
        Row(
          children: [_dado1_mesa(5), _dado1_mesa(5), _dado1_mesa(2)],
        ),
        Container(
          color: Colors.yellow,
          height: 10,
        ),
        //- 4 giuales---------
        util_texts_white_3_texto_extenso("Player win 2", 0.4),

        Row(
          children: [_dado1_mesa(2), _dado1_mesa(5)],
        ),
        util_texts_white_3_texto_extenso("four equals or two threesomes ", 0.4),
        Row(
          children: [
            _dado1_mesa(5),
            _dado1_mesa(5),
            _dado1_mesa(2),
            _dado1_mesa(2),
            _dado1_mesa(2)
          ],
        ),
        Container(
          color: Colors.yellow,
          height: 10,
        ),

        //---3 pares----
        util_texts_white_3_texto_extenso("Player win 3", 0.4),

        util_texts_white_3_texto_extenso("three pairs", 0.4),
        Row(
          children: [
            _dado1_mesa(5),
            _dado1_mesa(5),
          ],
        ),
        Row(
          children: [
            _dado1_mesa(2),
            _dado1_mesa(2),
            _dado1_mesa(1),
            _dado1_mesa(1),
            _dado1_mesa(4)
          ],
        ),
        Container(
          color: Colors.yellow,
          height: 10,
        ),
        //-------
        util_texts_white_3_texto_extenso("lost", 0.4),

        Row(
          children: [_dado1_mesa(2), _dado1_mesa(3)],
        ),
        util_texts_white_3_texto_extenso("table nothing ", 0.4),
        Row(
          children: [
            _dado1_mesa(1),
            _dado1_mesa(4),
            _dado1_mesa(5),
            _dado1_mesa(5),
            _dado1_mesa(2)
          ],
        ),

        //---------------
        //1
        util_texts_white_2_agregattamano(rule1, 0.7),

        util_texts_white_3_texto_extenso(textor1, 0.4),
        //2
        util_texts_white_2_agregattamano(rule2, 0.7),

        util_texts_white_3_texto_extenso(textor2, 0.4),
        //3
        util_texts_white_2_agregattamano(rule3, 0.7),

        util_texts_white_3_texto_extenso(textor3, 0.4),
        //4

//
      ],
    ),
  );
}

_3_tokkens_use(BuildContext context, int i) {
  String rule1 = "DarckChips";
  String rule2 = "DiamondChips";
  String rule3 = "Rule 3";
  String rule4 = "Rule 4";
  String rule5 = "Rule 5";
  String rule6 = "Rule 6";

  String textor1 =
      "Basic currency to play and bet, this is not used for the NFT or provides a purchase of any product that is not valid outside the game, mainly used for friendly games";
  //moneda basica para jugar y apostar, este no es usado para el NFT o proveee una dquisicion de ningun producto que no tenga validez fuera del juego
  String textor2 =
      "important currency, the diamond has a more realistic validity, it allows you to acquire through the NFT marketplace of our app and NFT content creation team directly to your wallet, be it coinbase or trust wallet, used within the app as currency of digital exchanges within the itself, tournaments and professional events.";
  //importante moneda el diamante tiene una validez mas realista, permite adquirir mediante el marketplace NFT de nuestra app y equipo de creacion de contenido NFT directo a tu wallet , sea coinbase o trust wallet ,usado dentro de la app como moneda de intercambios digitales dentro de la misma, torneos  y eventos profesionales.

  return Container(
    child: ListView(
      children: [
        //1
        util_texts_white_2_agregattamano(rule1, 0.7),

        util_texts_white_3_texto_extenso(textor1, 0.4),
        //2
        util_texts_white_2_agregattamano(rule2, 0.7),

        util_texts_white_3_texto_extenso(textor2, 0.4),
        //3
        util_texts_white_2_agregattamano(rule3, 0.7),

//
      ],
    ),
  );
}

_4_NFTandgiff_rewards(BuildContext context, int i) {
  String rule1 = "DarckChips";
  String rule2 = "DiamondChips";
  String rule3 = "Rule 3";
  String rule4 = "Rule 4";
  String rule5 = "Rule 5";
  String rule6 = "Rule 6";

  String textor1 =
      "Basic currency to play and bet, this is not used for the NFT or provides a purchase of any product that is not valid outside the game, mainly used for friendly games";
  //moneda basica para jugar y apostar, este no es usado para el NFT o proveee una dquisicion de ningun producto que no tenga validez fuera del juego
  String textor2 =
      "important currency, the diamond has a more realistic validity, it allows you to acquire through the NFT marketplace of our app and NFT content creation team directly to your wallet, be it coinbase or trust wallet, used within the app as currency of digital exchanges within the itself, tournaments and professional events.";
  //importante moneda el diamante tiene una validez mas realista, permite adquirir mediante el marketplace NFT de nuestra app y equipo de creacion de contenido NFT directo a tu wallet , sea coinbase o trust wallet ,usado dentro de la app como moneda de intercambios digitales dentro de la misma, torneos  y eventos profesionales.

  return Container(
    child: ListView(
      children: [
        //1
        util_texts_white_2_agregattamano(rule1, 0.7),

        util_texts_white_3_texto_extenso(textor1, 0.4),
        //2
        util_texts_white_2_agregattamano(rule2, 0.7),

        util_texts_white_3_texto_extenso(textor2, 0.4),
        //3
        util_texts_white_2_agregattamano(rule3, 0.7),

//
      ],
    ),
  );
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



//-opciones de compra sirve pero no lo usare en este
/*
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
        moneda_name: "How Play?",
        rutaimagen: "assets/2logoficha.png",
        cantidad: 700,
        prefio: "1 usd"),
    new Comprasmodel(
        moneda_name: "Numero de Jugadores",
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
            Navigator.pop(context);
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
*/
