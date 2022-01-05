import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criptodadosweb/loginweb/authservices.dart';
import 'package:criptodadosweb/pagues/criptogame/dados/jugardados.dart';
import 'package:criptodadosweb/pagues/login/perfil_usuario.dart';
import 'package:criptodadosweb/pagues/menuinicio.dart';
import 'package:criptodadosweb/pagues/models/buscarpartida.dart';
import 'package:criptodadosweb/pagues/models/pagos_bakcend/comprasmodel.dart';
import 'package:criptodadosweb/pagues/pagos_criptos/pagarcriptos.dart';
//import 'package:criptodadosweb/pagues/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

//void main() => runApp(MyApp());
/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}*/
/*Future<void> main() async {
  _verificacion_web(); //util aqui el codigo de obtener en firebase

  try {
    await Firebase.initializeApp();
  } on Exception catch (e) {
    print(e);
  }
  runApp(MyApp());
}*/
void main() async {
  print("iniciando app web ");

  // _verificacion_web();
  WidgetsFlutterBinding.ensureInitialized();
  print("iniciando app web ");

  /*await Firebase.initializeApp(
    name: "usuarios",
    options: const FirebaseOptions(
        apiKey: "AIzaSyBc1-uTBL5RH6-wKcEg1OvvpXkmIx62HLA",
        appId: "1:591288686983:web:70edff80d67712edf6db22",
        messagingSenderId: "591288686983",
        projectId: "criptocoin-6e89c"),
  );*/
  runApp(MyApp());
}

Future<void> _verificacion_web() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      name: "usuarios",
      options: const FirebaseOptions(
          apiKey:
              "393104966221-3ggsummou7c5nl6scb90dadi4t42te4d", // "AIzaSyBc1-uTBL5RH6-wKcEg1OvvpXkmIx62HLA",
          appId: "1:591288686983:web:70edff80d67712edf6db22",
          messagingSenderId: "591288686983",
          projectId: "criptocoin-6e89c"),
    );
  } else {
    await Firebase.initializeApp(name: "firestorename");
  }

  /// to get Firestore instance
  FirebaseFirestore? getFirestoreInstance() {
    for (var app in Firebase.apps) {
      if (app.name == "") {
        return FirebaseFirestore.instanceFor(app: app);
      }
    }
    return null;
  }

  /// use of instance
  FirebaseFirestore? instance = getFirestoreInstance();
  /*if (instance == null) {
    return likes;
  }
  QuerySnapshot<Map<String, dynamic>> snapshot =await instance.collection("my_doc").get();
*/
}
//
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var _partida_selec = Buscarpartida(
      numero: "numero",
      timestamp: "timestamp",
      nombre: "nombre",
      status: false,
      jugadoreson: player);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthService().handleAuth(),
        routes: {
          //login
          'playdados': (BuildContext context) => Jugardados(_partida_selec),
          //login
          //  'login': (BuildContext context) => LoginPage(),
          //'registro': (BuildContext context) => RegistroPague(),
          'perfil_user': (BuildContext context) => Perfil_Usuario(),
          'navegador': (BuildContext context) =>
              Menuinicio(), //puse navegador para que fuera mas sencillo los cambios
          //cointspay
          'coinbase': (BuildContext context) => pagarcriptos(new Comprasmodel(
              moneda_name: "moneda_name",
              rutaimagen: "rutaimagen",
              cantidad: 00,
              prefio: "")),
        });
    //  debugShowCheckedModeBanner: false,home: LoginPage());
    //  debugShowCheckedModeBanner: false,home: Container(child: Text("ASDFASDF"),));
  }
}
