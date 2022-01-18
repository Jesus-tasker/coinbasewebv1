import 'package:criptodadosweb/pagues/404/paguenotfound.dart';
import 'package:criptodadosweb/pagues/login/login_page.dart';
import 'package:criptodadosweb/pagues/login/perfil_usuario.dart';
import 'package:criptodadosweb/pagues/menuinicio.dart';
import 'package:criptodadosweb/pagues/menuinicio/menuiniciov2.dart';
import 'package:criptodadosweb/pagues/menuinicio/menuiniciov3.dart';
import 'package:criptodadosweb/pagues/models/buscarpartida.dart';
import 'package:criptodadosweb/pagues/models/pagos_bakcend/comprasmodel.dart';
import 'package:flutter/material.dart';

import '../pagues/criptogame/dados/jugardados.dart';
import '../pagues/pagos_criptos/pagarcriptos.dart';

//esto es para crear las rutas inciales en el main ongenerateroute para web 17/01/22
final _partida_selec = Buscarpartida(
    numero: "numero",
    timestamp: "timestamp",
    nombre: "nombre",
    status: false,
    jugadoreson: player);

class RouterGeneration {
//static   MaterialPageRoute
  static MaterialPageRoute generarruta(RouteSettings settings) {
    //elimine el estatic
    switch (settings.name) {
      case 'perfil_user':
        return MaterialPageRoute(
            settings: RouteSettings(
                // arguments: ,
                name: 'perfil_user'), //nombre de ruta y envia de objetos
            builder: (_) => Perfil_Usuario());
      case 'navegador':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/navegador'),
            builder: (_) => const Menuinicio());
      case 'coinbase':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/coinbase'),
            builder: (_) => pagarcriptos(Comprasmodel(
                moneda_name: "moneda_name",
                rutaimagen: "rutaimagen",
                cantidad: 00,
                prefio: "")));
      // ignore: no_duplicate_case_values
      case 'coinbase':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/playdados'),
            builder: (_) => Jugardados(_partida_selec)); //no estaticon

      case 'menuiniciov2':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/menuiniciov2'),
            builder: (_) => Menuiniciov2());
      case 'menuiniciov3':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/menuiniciov3'),
            builder: (_) => Menuiniciov3());
      //pagina no existe
      default:
        MaterialPageRoute(
            settings: RouteSettings(name: '/404'),
            builder: (_) => const Paguenotfound());
    }
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  //animacion y widget
  static PageRoute _faderoute(Widget child, String routename) {
    return PageRouteBuilder(
        settings: RouteSettings(name: routename),
        transitionDuration: Duration(microseconds: 200),
        pageBuilder: (_, __, ___) => child,
        transitionsBuilder: (_, animation, __, ___) =>
            //child
            FadeTransition(
              opacity: animation,
              child: child,
            ) //animacion

        );
  }
}
