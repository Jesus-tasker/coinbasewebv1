import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String? uid;
String? userEmail;

Future<User?> registerWithEmailPasswordweb(
    String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();
  User? user;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;
    }
  } catch (e) {
    print(e);
  }

  return user;
}

Future<User?> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();
  User? user;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth', true);
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}

//---------
final GoogleSignIn googleSignIn = GoogleSignIn();

String? name;
String? imageUrl;

Future<User?> signInWithGoogle() async {
  // Initialize Firebase
  await Firebase.initializeApp();
  User? user;

  // The `GoogleAuthProvider` can only be used while running on the web
  GoogleAuthProvider authProvider = GoogleAuthProvider();

  try {
    final UserCredential userCredential =
        await _auth.signInWithPopup(authProvider);

    user = userCredential.user;
  } catch (e) {
    print(e);
  }

  if (user != null) {
    uid = user.uid;
    //varname = user.displayName;
    userEmail = user.email;
    // imageUrl = user.photoURL;
//ejemplo original para web es lo mismo de shared preferences
//FORMA CORRECTA DE GUARDAR EN WEB LAS PREFERENCIAS
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);
    prefs.setString("nombreweb", user.displayName.toString());
    prefs.setString("fotoweb", user.photoURL.toString());
    prefs.setString("tokenweb", user.uid.toString());
    prefs.setString("telefonoweb", user.phoneNumber.toString());

    print("autenticado con google WEB ");
//-------en app
/*
    final _pref_user = PreferenciasUsuario();
    _pref_user.nombre = user.displayName.toString();
    _pref_user.foto = user.photoURL.toString();
    _pref_user.token = user.uid.toString();
    _pref_user.telefono = user.phoneNumber.toString();
    // ignore: avoid_print
    print("autenticado con google ");*/
  }

  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;

  print("User signed out of Google account");
}
