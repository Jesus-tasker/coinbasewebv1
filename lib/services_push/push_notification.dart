//SHA1: D5:A9:63:AF:7F:A6:59:15:4E:C9:56:71:D0:0E:81:04:5A:05:11:06

import 'dart:async';

import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  // ignore: non_constant_identifier_names
  //FirebaseMessaging messaging = FirebaseMessaging.instance;
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token_notifi;

  //3, variable para pasar datos con notificacion
  static StreamController<String> _mensaje_streamController =
      new StreamController.broadcast();
  //3.1.0
  static Stream<String> get messagestream => _mensaje_streamController.stream;

  static get user_auth => null; //leugo hay qeu inscribirlo ene l manin

// final  _emailController = StreamController<String>.broadcast();

//2.1 las entradas d elas notificaciones

  // ignore: non_constant_identifier_names
  static Future _background_handler(RemoteMessage message) async {
    //app
    print(' backfround  handler ${message.messageId}');
    print("");
    print('${message.data}'); //json oculto con informacion {data: "hola"}

    // _mensaje_streamController.add(message.notification?.title ??"No title"); //operador con ??  es para decir que si no viene le pase solo comillas

    _mensaje_streamController.add(message.notification?.body ??
        "No body "); //los datos que puedo enviar desde una version personalizada el json
  }

  // ignore: non_constant_identifier_names
  static Future _on_mesagend_handler(RemoteMessage message) async {
    print(' on messaje  handler ${message.messageId}'); //app abierta...
    print('${message.data}');
    print("");

    _mensaje_streamController.add(message.notification?.title ??
        "No title"); //operador con ??  es para decir que si no viene le pase solo comillas

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }

  // ignore: non_constant_identifier_names
  static Future _on_mensaje_open_app_dhandler(RemoteMessage message) async {
    print(' on mensaje open app  handler ${message.messageId}');

    print('${message.data}');
    _mensaje_streamController.add(message.notification?.title ??
        "No title"); //operador con ??  es para decir que si no viene le pase solo comillas

    //4.2 obtener el data
    _mensaje_streamController
        .add(message.data['Producto'] ?? "No data"); // {'producto':'corte'}

    //print('A new onMessageOpenedApp event was published!');
    //Navigator.pushNamed(context, '/message',  arguments: MessageArguments(message, true));

    print("");
  }

  //1. va ene el main
  static Future inicialiceapp() async {
    //PUSH NOTIFICACION
    await Firebase.initializeApp();
    var tokken = await FirebaseMessaging.instance.getToken();
    print('Token notifty : $tokken');

    final _pref_user = new PreferenciasUsuario(); //shared preferences
    await _pref_user.initPrefs(); //shared pref

    if (tokken != null && tokken != "") {
      _pref_user.token_notifi = tokken.toString();
      String toke = _pref_user.token_notifi;
      print('Token notifty guardado  : $toke');

//wqeb 1 quiza funciones aun no se lo invente
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //  prefs.setBool('auth', true);
      prefs.setString("notifiweb", user_auth!.displayName!);

      // prefs.setString("nombreweb", user_auth!.displayName!);
    }

    //2. HANDLERS: ESTADOS DE LA NOTIFICACION  ESTAN ARRIBA
    FirebaseMessaging.onBackgroundMessage(_background_handler); //app cerrada
    FirebaseMessaging.onMessage.listen(
        _on_mesagend_handler); //app abierta //solo en esta no me muestra la notificacion
    FirebaseMessaging.onMessageOpenedApp
        .listen(_on_mensaje_open_app_dhandler); //recibe con app abierta

    /////---------

    //apple //quizas opcionalR
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        badge: true,
        alert: true,
        sound:
            true); //presentation options for Apple notifications when received in the foreground.

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  //3.2 esto se llama para saber cuando queremos cerrar la notificacion , sirve mas como requisito ya que da igual
  static closeStreams() {
    _mensaje_streamController.close();
  }
}
