//aqui podemos definir si un dato es un numero o tal
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s); //si se puede parcear a  nuemro
  return (n == null) ? false : true; //si n=null else = true
}

//mensaje de aler dialog
mostraralerta(BuildContext context, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(' informacion incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
          ],
        );
      });
}

show_buttonsheep_util(BuildContext contex, String dato) {
  return new Container(
//        height: 320.0,
//      color: Colors.greenAccent,
    child: new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 5.0, childAspectRatio: 1.0),
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
              // child: new Image.asset('images/${urlItems[index]}', width: 50.0, height: 50.0, fit: BoxFit.fill,),
            ),
            new Text(dato)
          ],
        );
      },
      //itemCount: nameItems.length,
    ),
  );
}

mostrardialogbuttonshet(BuildContext contex, String dato) {
  showModalBottomSheet(
    context: contex,
    builder: (context) => GestureDetector(
      child: Container(
        height: 50,
        child: Row(children: [
          Text('$dato'),
          Icon(Icons.delete),
        ]),
      ),
      onVerticalDragStart: (_) {},
    ),
  );
}

mostrar_fulldialog(BuildContext context, int i) {
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
            Expanded(
              flex: 5,
              child: SizedBox.expand(
                  child: FlutterLogo()), //aqui mostraba el logo de flutter
            ),
            Expanded(
              flex: 1,
              child: SizedBox.expand(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Dismiss',
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

//fondo
Widget crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;

  final fondoModaro = Container(
    height: size.height * 1,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
      Color.fromRGBO(90, 70, 178, 1),
      Color.fromRGBO(10, 30, 60, 1),
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
      Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            Icon(Icons.person_add, color: Colors.white, size: 100.0),
            SizedBox(height: 10.0, width: double.infinity),
            Text('Unete a nosotros!',
                style: TextStyle(color: Colors.white, fontSize: 25.0))
          ],
        ),
      )
    ],
  );
}

cuadrado_qr() {
  return Card(
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: IconButton(icon: Icon(Icons.qr_code), onPressed: null)));
}
