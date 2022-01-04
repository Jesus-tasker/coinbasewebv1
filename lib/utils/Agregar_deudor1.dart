import 'package:flutter/material.dart';

import '../pagues/models/deuda_model.dart';

class Agregar_deudor extends StatefulWidget {
  Agregar_deudor({Key? key}) : super(key: key);

  @override
  Agregar_deudorState createState() => Agregar_deudorState();
}

class Agregar_deudorState extends State<Agregar_deudor> {
  // Deuda deuda = new Deuda(deuda: Cliente(cedula: "cedula", nombre: "nombre", telefono: "telefono", direccion: "direccion"),Finanza(fechainicio: "fechainicio", prestamoinicial: "prestamoinicial", deudapendiente: "deudapendiente", interes: "interes"));
  //Deuda deuda=new Deuda(deuda: )
  Cliente cliente = new Cliente(
      cedula: "cedula", nombre: "nombre", telefono: 0, direccion: "direccion");
  Finanzas finanzas = new Finanzas(
      fechainicio: "fechainicio",
      prestamoinicial: 100000,
      deudapendiente: false,
      interes: 10);

  var interes_sobre_base = 0;
  //no terminado
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  bool btn_pulsado_bool = false;

  @override
  Widget build(BuildContext context) {
    interes_sobre_base = finanzas.prestamoinicial;
    var interes10 = (interes_sobre_base * 10) / 100;
    var pagomensual = (interes10 / 10);

    var total_anual = (finanzas.prestamoinicial + interes10);
    var cuotas_fijas = (total_anual / 12);
    //cuuotas mensuales=total prestamos+interes/12

    ///---------

    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    finanzas.fechainicio = DateTime.now().year.toString() +
        "/" +
        DateTime.now().month.toString() +
        "/" +
        DateTime.now().day.toString(); //dateToday.toString();
    //---------

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //  title: 'Nuevo cliente',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calcular  Prestamo'),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // _iconos_galeriay_camara(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text(""),
                        // width: double.infinity / 3,
                      ),
                      Text(finanzas.fechainicio),
                    ],
                  ),
                  _escribir_cedula(),
                  _escribir_nombreUsuario(),
                  _escribir_telefono(),
                  _escribir_direccion_completa(),

                  //  _prestamo_inicial(),
                  TextFormField(
                    initialValue:
                        finanzas.prestamoinicial.toString(), //valor del modelo
                    maxLength: 6,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal:
                            true), //que acepte solo datos y especifica que recibe decimales
                    decoration: InputDecoration(labelText: 'monto'),
                    onSaved: (valor) => finanzas.prestamoinicial =
                        int.parse(valor!), //guarda el valor
                    //valor as double, //aqui guardamos el valor que se utilizo
                    onChanged: (texto) {
                      // int n = finanzas.prestamoinicial;
                      // interes_sobre_base = ((n * finanzas.interes) / 100) as int;

                      // finanzas.prestamoinicial = texto as int; //valor cuando cambia la letra
                      setState(() {
                        print(texto);
                        int totalamount = int.parse(texto);

                        finanzas.prestamoinicial = totalamount;
                        // texto as int; //valor cuando cambia la letra
                      });
                    },
                    validator: (valor) {
                      //utils es una validacion que hice para ver si es un numero
                      if (_isNumerico(valor!)) {
                        //si regresa un true es un numero ,
                        return null;
                      } else {
                        return '80.000 ';
                      }
                    },
                  ),
                  Text("Interes : 10%"),
                  Text("interes total: " + interes10.toString()),
                  Text("cuotas: 12"),
                  Text("cuotas mensuales: " +
                      cuotas_fijas.roundToDouble().toString()),
                  Text("Pago Total: " + total_anual.toString()),
                  _btn_guardadrinfo(context),

                  //  _btn_guardadrinfo(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _escribir_nombreUsuario() {
    return TextFormField(
        initialValue: cliente.nombre, //nombre model
        maxLength: 30,
        keyboardType:
            TextInputType.name, //que acepte solo datos y especifica que recibe
        decoration: InputDecoration(labelText: 'Nombre'),
        onChanged: (texto) {
          cliente.nombre = texto; //valor cuando cambia la letra
        },
        onSaved: (valor) => cliente.nombre = valor!,
        validator: (value) {
          //validamos lo que escribe en el campo
          if (value!.length < 3) {
            return 'ingresar nombre Usuario';
          } else {
            return null;
          }
        });
  }

  Widget _escribir_cedula() {
    return TextFormField(
      // initialValue: cliente.telefono.toString(), //valor del modelo
      maxLength: 10,
      keyboardType: TextInputType.numberWithOptions(
          decimal:
              true), //que acepte solo datos y especifica que recibe decimales
      decoration: InputDecoration(labelText: 'Cedula'),
      onSaved: (valor) =>
          cliente.telefono = int.parse(valor!), //guarda el valor
      //valor as double, //aqui guardamos el valor que se utilizo
      onChanged: (texto) {
        int totalamount = int.parse(texto);

        cliente.cedula = totalamount.toString();
      },
      validator: (valor) {
        //utils es una validacion que hice para ver si es un numero
        if (_isNumerico(valor!)) {
          //si regresa un true es un numero ,
          return null;
        } else {
          return '1070791702';
        }
      },
    );
  }

  Widget _escribir_telefono() {
    return TextFormField(
      initialValue: cliente.telefono.toString(), //valor del modelo
      maxLength: 10,
      keyboardType: TextInputType.numberWithOptions(
          decimal:
              true), //que acepte solo datos y especifica que recibe decimales
      decoration: InputDecoration(labelText: 'Telefono'),
      onSaved: (valor) =>
          cliente.telefono = int.parse(valor!), //guarda el valor
      //valor as double, //aqui guardamos el valor que se utilizo
      onChanged: (texto) {
        int totalamount = int.parse(texto);

        cliente.telefono = totalamount;
      },
      validator: (valor) {
        //utils es una validacion que hice para ver si es un numero
        if (_isNumerico(valor!)) {
          //si regresa un true es un numero ,
          return null;
        } else {
          return '+56: solo Numero telefonico ';
        }
      },
    );
  }

  bool _isNumerico(String s) {
    if (s.isEmpty) return false;
    final n = num.tryParse(s); //si se puede parcear a  nuemro
    return (n == null) ? false : true; //si n=null else = true
  }

  Widget _escribir_direccion_completa() {
    return TextFormField(
        initialValue: cliente.direccion.toString(), //valor del modelo
        maxLength: 50,
        keyboardType: TextInputType
            .streetAddress, //que acepte solo datos y especifica que recibe decimales
        decoration: InputDecoration(labelText: 'Direccion'),
        onSaved: (valor) => cliente.direccion = valor!,
        onChanged: (texto) {
          cliente.direccion = texto; //valor cuando cambia la letra
        },
        validator: (value) {
          //validamos lo que escribe en el campo
          if (value!.length < 9) {
            return 'ingresar direccion completa ';
          } else {
            return null;
          }
        });
  }

  //finanzas

  ///---------maps over arriba
  Widget _btn_guardadrinfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        disabledColor: Colors.amber,
        child: Text("Guardar informacion "),
        splashColor: Colors.amber,
        color: Colors.green,
        //icon: Icon(Icons.save),
        onPressed: () async {
          new Container(
            child: CircularProgressIndicator(
              //color: Colors.accents,
              valueColor: AlwaysStoppedAnimation(Colors.green),
            ),
          );

          //actualizar informacion usuario

          setState(() {
            btn_pulsado_bool = true;
          });

          _validarformulario(context);
        },
      ),
    );
  }

  void _validarformulario(BuildContext context) {
    if (cliente.cedula != "" &&
        cliente.nombre != "" &&
        cliente.telefono != 0 &&
        cliente.direccion != "" &&
        finanzas.prestamoinicial > 1000) {
      //aqui podemos guardar la informacione n neustro abckend en este caso creare una peticion aun servidor que podria almacenar esta informacion mediante un json
      var clientejson = cliente.toJson();
    }

    _mostrardialogbuttonshet(BuildContext contex, String dato, bool estado) {
      var color_selected = Colors.red[100];
      var iconselected = Icons.info_outline;
      if (estado == true) {
        color_selected = Colors.green[100];
        iconselected = Icons.exit_to_app;
        showModalBottomSheet(
          context: contex,
          builder: (context) => GestureDetector(
            child: Container(
              color: color_selected,
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              height: 150,
              child: Row(children: [
                Text('$dato'),
                Icon(iconselected),
              ]),
            ),
            onVerticalDragStart: (_) {},
          ),
        );
      }
    }
  }
}
