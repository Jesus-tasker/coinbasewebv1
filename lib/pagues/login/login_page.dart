import 'package:flutter/material.dart';
import 'package:criptodadosweb/bloc/login_bloc.dart';
import 'package:criptodadosweb/bloc/provider_bloc.dart';
import 'package:criptodadosweb/providers/login/Usuario_provider.dart';
import 'package:criptodadosweb/utils/utils.dart';
import 'package:criptodadosweb/utils/utils_textos.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

import 'gogogle_sing_provider.dart';

class LoginPage extends StatelessWidget {
  final usuario_prov = new Ususario_Provider();

  @override
  Widget build(BuildContext context) {
    //original no se usa
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context), //lo crea
        _loginForm(context),

        ///aqui ahi errores
      ],
    ));
    /* var widgetapp = Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return mostraralerta(context, "algo ha salido mal");
              } else if (snapshot.hasData) {
                return Loggesd_widget(); //mostraralerta(context, "algo ha salido mal");
              } else {
                return Stack(
                  children: <Widget>[
                    _crearFondo(context),
                    _loginForm(context),
                  ],
                );
              }
            }));

  */
  }

  Widget _loginForm(BuildContext context) {
    // ignore: non_constant_identifier_names
    //patron bloc genera errores
    print("llega al texto login form------------");
    // ignore: non_constant_identifier_names
    final bloc_provider = Provider_bloc.of(context);

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
                color: Colors.black45, //Colors.white54,
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
                  // width: size.width * 0.85,
                  // margin: EdgeInsets.symmetric(vertical: 30.0),
                  // padding: EdgeInsets.symmetric(vertical: 50.0),
                  decoration: BoxDecoration(
                      //  color: Colors.white,
                      borderRadius: BorderRadius.circular(110),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3.0,
                            offset: Offset(0.0, 5.0),
                            spreadRadius: 3.0)
                      ]),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color.fromRGBO(50, 20, 200, 0.8),
                      child: CircleAvatar(
                        //   radius: 30,
                        //child: Image.asset('assets/logo1.png'),
                        backgroundImage: AssetImage('assets/fondo2cripto.png'),
                        radius: 99,

                        //  borderColor: Colors.yellow,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: util_texts_white_2_agregattamano('Iniciar sesion', 3),
                  /*Text(
                    'Iniciar sesion',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromRGBO(10, 70, 110, 1),
                      fontFamily: 'MyFont',
                    ),
                    textDirection: TextDirection.ltr,
                    // style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.4,
                  ),*/
                ),
                SizedBox(height: 60.0),
                _crearEmail(bloc_provider),
                SizedBox(height: 30.0),
                // _crearPassword(bloc_provider),
                SizedBox(height: 30.0),
                //  _crearBoton(bloc_provider),
                SizedBox(height: 30.0),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    //funciona pero lo pauso para provar que genera el daño
                    final provider_authgoogle =
                        Provider.of<GoogleSingInProvider>(context,
                            listen: false);
                    provider_authgoogle.googlelogin();
                  },
                )
              ],
            ),
          ),
          FlatButton(
              disabledTextColor: Colors.white60,
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'registro'),
              child: Text(
                'crear una nueva cuenta',
                textScaleFactor: 1.4,
                style: TextStyle(color: Colors.white),
              )),
          Text(
            '¿Olvido la contraseña?',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 30),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.white),

              hintText: 'ejemplo@correo.com',

              labelText: 'Correo electrónico',
              labelStyle: TextStyle(
                color: Colors.white38,
              ),
              hintStyle: TextStyle(color: Colors.white54),
              counterText: snapshot.data,
              //errorText: snapshot.error.toString()
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 30),
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.white),
              labelText: 'Contraseña',
              labelStyle: TextStyle(
                color: Colors.white38,
              ),
              hintStyle: TextStyle(color: Colors.white54),

              // counterText: snapshot.data,
              //errorText: snapshot.error.toString()
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      //stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
                //   height: 70,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: util_texts_black2_agregattamano("Ingresar", 1.3)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            //  textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
      },
    );
  }

  _sing_with_google(BuildContext context) async {
    // _sing_with_google(context),
    /*   Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: Size(double.infinity, 50)),
                      onPressed: () async {
                        final provider_authgoogle =
                            Provider.of<GoogleSingInProvider>(context,
                                listen: false);
                        provider_authgoogle.googlelogin();
                      },
                      //child: Text("Sing up with Google")),
                      icon: Icon(Icons.person), // faIcon,//Favicon(Font)),

                      label: Text("Sing up with Google")),
                ),
             */

    return SignInButton(
      Buttons.Google,
      text: "Sign up with Google",
      onPressed: () async {
        final _provider_authgoogle =
            Provider.of<GoogleSingInProvider>(context, listen: false);
        _provider_authgoogle.googlelogin();
      },
    );
  }

  //Login correcto
  _login(LoginBloc bloc, BuildContext context) async {
    //map=una espera de obtencion de informacion // 'ok': true,
    //  Firebase.initializeApp(); //NO se si esta bien
    Map info = await usuario_prov.login(bloc.email, bloc.password);

    if (info['ok']) {
      //si es valido y me retorna un true

      Navigator.pushReplacementNamed(context, 'navegador');
    } else {
      mostraralerta(context, info['mensaje']);
    }

    //validamos si existe la informcaion en preferences

    /*  print('================');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('================');

    Navigator.pushReplacementNamed(context, 'home');*/
  }

  _loginv2_auth(LoginBloc bloc, BuildContext context) async {
    final auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(email: bloc.email, password: bloc.password)
        .then((_) {
      Navigator.pushReplacementNamed(context, 'navegador');
    });
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: double.infinity, //size.height * 1,
      width: double.infinity,

      //child: Image.asset("assets/2logoficha.png"),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: LinearGradient(colors: <Color>[
            //Color.fromRGBO(63, 63, 156, 1.0),
            //Color.fromRGBO(90, 70, 178, 1.0)
            // Color.fromRGBO(10, 30, 60, 1),
            // Color.fromRGBO(10, 30, 60, 1),
            Color.fromRGBO(90, 70, 178, 1.0),
            // Color.fromRGBO(10, 110, 18, 0.4),
            // Color.fromRGBO(10, 20, 180, 4.0), //violeta claro
            Colors.white38,
            Colors.white38,
            //Color.fromRGBO(10, 110, 18, 0.4),
            Color.fromRGBO(90, 70, 178, 1.0)
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
        _0003regresar_fondoimagen(context),
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              // Icon(Icons.baby_changing_station, color: Colors.white, size: 100.0),

              SizedBox(height: 10.0, width: double.infinity),
              Text('Bienvenidos a CasinosCripto!',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  _0003regresar_fondoimagen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //01_fondo_gris_juegodados.jpg
    //1fondoverde.png
    return Container(
        height: size.height,
        // width: size.width,
        child: Expanded(
          //  flex: 7,
          child: Image(
              image: AssetImage(
                "assets/fondo3gold.png",
              ),
              fit: BoxFit.cover),
        ));
  }
}
