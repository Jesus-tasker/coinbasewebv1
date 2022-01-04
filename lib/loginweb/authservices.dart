import 'dart:developer';

import 'package:criptodadosweb/loginweb/homeweb.dart';
import 'package:criptodadosweb/loginweb/intento2/authdialog.dart';
import 'package:criptodadosweb/loginweb/loginwebscreen.dart';
//import 'package:criptodadosweb/loginweb/loginwebscreen.dart';
import 'package:criptodadosweb/pagues/login/login_page.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:flutter/material.dart';

class AuthService {
  //Handle Authentication
  handleAuth() {
    return StreamBuilder(
      stream:
          FirebaseAuthWeb.instance.authStateChanges(), //.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("buscando pagina logiueado ");
          return HomePageweb();
        } else {
          // return LoginPage(); //LoginPage_web(

          return AuthDialogweb(); //LoginPage_web(); //casi funciona
        }
      },
    );
  }

  //Sign Out
  signOut() {
    FirebaseAuthWeb.instance.signOut();
  }

  //Sign in
  signIn(email, password) {
    FirebaseAuthWeb.instance.signInWithEmailAndPassword(email, password)
        // .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      // print('Signed in');
      log("signed in");
    }).catchError((e) {
      print(e);
    });
  }
}
