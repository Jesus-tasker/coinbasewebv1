import 'package:criptodadosweb/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

//import 'package:flutter/foundation.dart';

// ignore: camel_case_types
class Provider_bloc extends InheritedWidget {
  ///provider es un wiget que con claves puede almacenar informacion y ubicarla usando patron block

  final loginBloc = LoginBloc(); //login block
  // final _productoblock = new ProductosBlock(); //productos block

  static Provider_bloc?
      _instancia; //originalmente privada la cambie el 17/12 para probar algo

  factory Provider_bloc({Key? key, required Widget child}) {
    //
    _instancia ??= Provider_bloc._internal(key: key, child: child);
    // _instancia = Provider_bloc._internal(key: key, child: child);
    /*  if (_instancia == null) {
      // _instancia = new Provider_bloc._internal(key: key, child: child);
      //_instancia = new Provider_bloc._internal(child: child);
     // _instancia = new Provider_bloc(child: child);

    }*/
    //_instancia ??= new Provider_bloc._internal(key: key, child: child);
    // return new Provider(key: key, child: child);
    //return Provider(key: key, child: child);
    /*   if (_instancia == null) {
      _instancia = new Provider_bloc._internal(key: key, child: child);
    } */
    return _instancia!;
  }
  Provider_bloc._internal({Key? key, required Widget child})
      : super(key: key, child: child);

  @override //cone sto buscamos la ingormacion
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    //busca algo que se llame provider y tratao como provider eso es lo que dice
    return (context.dependOnInheritedWidgetOfExactType<Provider_bloc>()
            as Provider_bloc)
        .loginBloc;
  }
}

    //return Provider(key: key, child: child);
  //   return _instancia; //= new Provider._internal(key: key, child: child);
   //return Provider(key: key, child: child); 