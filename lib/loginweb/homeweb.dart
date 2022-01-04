import 'dart:async';

import 'package:criptodadosweb/loginweb/authservices.dart';
import 'package:flutter/material.dart';

class HomePageweb extends StatefulWidget {
  @override
  _HomePagewebState createState() => _HomePagewebState();
}

class _HomePagewebState extends State<HomePageweb> {
  @override
  Widget build(BuildContext context) {
    print("homepagueview----");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You are logged in'),
          SizedBox(height: 10.0),
          RaisedButton(
            onPressed: () {
              AuthService().signOut();
            },
            child: Center(
              child: Text('Sign out'),
            ),
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
