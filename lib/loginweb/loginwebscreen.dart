import 'package:criptodadosweb/loginweb/authservices.dart';
import 'package:flutter/material.dart';

class LoginPage_web extends StatefulWidget {
  @override
  _LoginPage_webState createState() => _LoginPage_webState();
}

class _LoginPage_webState extends State<LoginPage_web> {
  late String email, password;

  final formKey = new GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                height: 250.0,
                width: 300.0,
                child: Column(
                  children: <Widget>[
                    Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 5.0),
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Email'),
                                    validator: (value) => value!.isEmpty
                                        ? 'Email is required'
                                        : validateEmail(value.trim()),
                                    onChanged: (value) {
                                      this.email = value;
                                    },
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 5.0),
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration:
                                        InputDecoration(hintText: 'Password'),
                                    validator: (value) => value!.isEmpty
                                        ? 'Password is required'
                                        : null,
                                    onChanged: (value) {
                                      this.password = value;
                                    },
                                  ),
                                )),
                            InkWell(
                                onTap: () {
                                  if (checkFields()) {
                                    AuthService().signIn(email, password);
                                  }
                                },
                                child: Container(
                                    height: 40.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                    ),
                                    child: Center(child: Text('Sign in'))))
                          ],
                        ))
                  ],
                ))));
  }
}
