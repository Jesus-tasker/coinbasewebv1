import 'package:criptodadosweb/loginweb/intento2/googlebuttonweb.dart';
import 'package:flutter/material.dart';

class AuthDialogweb extends StatefulWidget {
  @override
  _AuthDialogwebState createState() => _AuthDialogwebState();
}

String _email = "", _contrasena = "";

class _AuthDialogwebState extends State<AuthDialogweb> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // ...
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Bienvenidos a Criptodados por favor inicie cesión"),
                Text(
                    "Apta solo para mayores de 18 años y amantes  de la revolucion digital cripto  "),

                //  Text('Email address'),
                // _crearEmail(),
                //Text('Password'),
                //  _crearPassword(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.maxFinite,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.maxFinite,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign up',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(child: GoogleButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _crearEmail() {
  return StreamBuilder(
    //  stream: bloc.emailStream,
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
          // onChanged: bloc.changeEmail,
          // onChanged: _email,
        ),
      );
    },
  );
}

Widget _crearPassword() {
  return StreamBuilder(
    //  stream: bloc.passwordStream,
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
          //  onChanged: bloc.changePassword,
        ),
      );
    },
  );
}
