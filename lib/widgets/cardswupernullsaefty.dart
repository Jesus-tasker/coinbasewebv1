import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../pagues/criptogame/v2/provider1_ibuscarpartida.dart';
import '../pagues/models/materias_elegir.dart';

class Card_swipeer_nullsaefty extends StatelessWidget {
  //pasamos la lista del objteo como si fuera el adapter para mostrarlo
  // const Card_swipeer({Key key}) : super(key: key);

  final List<Materias> materiaslist;

  Card_swipeer_nullsaefty(
      {required this.materiaslist}); //esto obliga a que debe tenerel requisito d ela lista para funcionar

  // materiaslist[index].idMaterias =
  //   '${materiaslist[index].idMaterias}_tarjeta'; //video 119 y 315
  //navegacion
  /* Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Compras_carrito2(
                              materiaslist, materiaslist[index].materia)),
                      (r) => false,
                    ); */
  @override
  Widget build(BuildContext context) {
    //para vambiar el tamaño de las tarjetas usamos el tamaño del sispitivo
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla
    CarouselController buttonCarouselController = CarouselController();
    return CarouselSlider.builder(
        carouselController: buttonCarouselController,
        itemCount: materiaslist.length,
        itemBuilder: (context, index, realindex) => vistacard1(
              materiaslist: materiaslist[index],
              materiaslist_filter1: materiaslist,
            ),
        options: CarouselOptions(
            enableInfiniteScroll: true,
            autoPlay: true,
            reverse: true,
            autoPlayInterval: const Duration(seconds: 2),
            // true,
            aspectRatio: 2.0,
            enlargeCenterPage: true));

    /*  return Container(
      //CONTENEDOR CON EL SWIPE <..> PARA MOVERSE
      //le decimos el tamaño que debe tener y donde sacar las imagens
      width: double.infinity, //usar tood el ancho
      padding: EdgeInsets.only(top: 10), //pading superos
      //width: _screensize.width * 0.7 , //que el tamaño sea el 70% de ancho en la pantalla
      height: _screensize.height * 0.4, //la mitad del dispitivo

      child: Swiper(
        //tabulador paginador mejor que paper adapter
        layout:
            SwiperLayout.STACK, //aqui pasamos el tipo de paginacion el efecto
        itemHeight: _screensize.width * 0.8,
        itemWidth: 250, // _screensize.height * 0.3,
        itemBuilder: (BuildContext context, int index) {
          //hace el ciclo de los elementos como peliuclas el ciclo for
          // materiaslist[index].idMaterias =
          //   '${materiaslist[index].idMaterias}_tarjeta'; //video 119
          //arriba creamos el id unico para que no se repita cuando pasamos parametros entre actividades
          return Hero(
            tag: materiaslist[index].idMaterias,
            child: ClipRRect(
                //clip reect para poner el border y dento ponemos la imagen
                borderRadius: BorderRadius.circular(20),
                child:
                    //new Image.network("http://via.placeholder.com/350x150", fit: BoxFit.cover,
                    //fit se adapta a las dimensiones que tiene,
                    GestureDetector(
                  //wiget para pasar entre activityes
                  onTap: () {
                    print('tappp');
                   
                    //  Navigator.pushNamed(context, "detalle",
                    //    arguments: materiaslist[index]);
                  },
                  child: vistacard1(materiaslist: materiaslist),
                )),
          );
        },
        itemCount: materiaslist.length, //3,
        //pagination:    new SwiperPagination(), //viene por defecto es para mostrar los puntitos de abajo para paginar
        control:
            new SwiperControl(), //viene por defecto para mover hacia los ladors
      ),
    );
 */
  }
}

class vistacard1 extends StatelessWidget {
  const vistacard1(
      {Key? key,
      required this.materiaslist,
      required this.materiaslist_filter1})
      : super(key: key);

  final Materias materiaslist;

  final List<Materias> materiaslist_filter1;

  @override
  Widget build(BuildContext context) {
    var color_principal = Color.fromARGB(58, 83, 10, 88);
    final _screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        dialog_buscandopartida(context, 1, 500);

        /* Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Compras_carrito2(materiaslist_filter1, materiaslist.materia)),
          (r) => false,
        );*/
      },
      child: Container(
        child: Stack(
          children: [
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(width: 1, color: color_principal)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    height: _screensize.height * 0.7, //double.infinity,
                    child: FadeInImage(
                      image: AssetImage(materiaslist.fotoUrlFondo),
                      placeholder: const AssetImage('assets/no-image.png'),
                    )
                    /* FadeInImage(
                    image: NetworkImage(materiaslist
                        .getposterimage()),/ // peliculas_list[index].getposterimage()
                    placeholder: AssetImage('assets/no-image.png'),
                    fit: BoxFit.cover, //reparo el error del controno medio ciruclar
                  ),*/
                    ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 30,
                alignment: Alignment.topCenter,
                color: Colors.white38,
                child: ClipRRect(
                  //clip reect para poner el border y dento ponemos la imagen
                  borderRadius: BorderRadius.circular(20),
                  child: Text(
                    materiaslist.materia,
                    // Text(materiaslist[index].materia,
                    //textScaleFactor: 24,
                    textScaleFactor: 2,

                    overflow: TextOverflow
                        .ellipsis, //cuando el texto no cabe pone puntitos
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ),
            Container(
              //  height: 100,
              alignment: Alignment.bottomCenter,
              // color: Colors.white38,
              child: ClipRRect(
                //clip reect para poner el border y dento ponemos la imagen
                borderRadius: BorderRadius.circular(20),
                child: Text(
                  materiaslist.descripcion,
                  //textScaleFactor: 24,
                  textScaleFactor: 2,

                  overflow: TextOverflow
                      .ellipsis, //cuando el texto no cabe pone puntitos
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
