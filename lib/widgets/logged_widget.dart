import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loggesd_widget extends StatelessWidget {
  //const Loggesd_widget({Key? key}) : super(key: key);
  final user_auth = FirebaseAuthWeb.instance.currentUser;
  final _pref_user = new PreferenciasUsuario(); //shared preferences

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      padding: EdgeInsets.all(80),
      child: ClipRect(
        child: Center(
          child: Column(
            children: [
              Text("profile"),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user_auth!.photoURL.toString()),
              ),
              Text(user_auth!.displayName.toString()),
              Text(user_auth!.email.toString()),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: Size(double.infinity, 50)),
                  onPressed: () {
                    _pasar_perfiluser(context);
                  },
                  //child: Text("Sing up with Google")),
                  icon: Icon(Icons.person), // faIcon,//Favicon(Font)),
                  label: Text("Continuar "))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pasar_perfiluser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);
    prefs.setString("nombreweb", user_auth!.displayName!);
    prefs.setString("fotoweb", user_auth!.photoURL!);
    prefs.setString("tokenweb", user_auth!.uid);
    // prefs.setString("telefonoweb", user.phoneNumber.toString());

    _pref_user.foto = user_auth!.photoURL!;
    _pref_user.nombre = user_auth!.displayName!;
    _pref_user.token = user_auth!.uid;
    print("..................................token");
    print(_pref_user.token);

    // Navigator.pushNamed(context, 'menuiniciov2');

    Navigator.pushNamed(context, 'navegador');
    // Navigator.pushNamed(context, 'perfil_user'); //(context, 'perfil_user');
    //cambiado
  }

//NO
  _mostrar_fulldialog_logger_data(BuildContext context, int i) {
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
}
