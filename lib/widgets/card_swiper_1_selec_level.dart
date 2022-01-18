/*import 'package:criptodadosweb/pagues/models/materias_elegir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Card_swipeer extends StatelessWidget {
  //pasamos la lista del objteo como si fuera el adapter para mostrarlo
  // const Card_swipeer({Key key}) : super(key: key);

  final List<Materias> materiaslist;

  Card_swipeer(
      {required this.materiaslist}); //esto obliga a que debe tenerel requisito d ela lista para funcionar

  @override
  Widget build(BuildContext context) {
    //para vambiar el tamaño de las tarjetas usamos el tamaño del sispitivo
    final _screensize =
        MediaQuery.of(context).size; //obtenemos tamaño d ela pantalla

    return Container(
      //CONTENEDOR CON EL SWIPE <..> PARA MOVERSE
      //le decimos el tamaño que debe tener y donde sacar las imagens
      width: double.infinity, //usar tood el ancho
      padding: EdgeInsets.only(top: 10), //pading superos
      //width: _screensize.width * 0.7 , //que el tamaño sea el 70% de ancho en la pantalla
      height: _screensize.height * 0.5, //la mitad del dispitivo

      child: Swiper(
        //tabulador paginador mejor que paper adapter
        layout:
            SwiperLayout.STACK, //aqui pasamos el tipo de paginacion el efecto
        itemHeight: _screensize.width * 0.8,
        itemWidth: 300, // _screensize.height * 0.3,
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
                    //aqui empieza el juego supongamos que es con 1 jugador
                    //buscar o crear una partida

                    //1 BUSCANDO PARTIDA
                    //ENLISTARSE EN UNA LISTA USUARIOS
                    //// STATUS :ON
                    //12:01-timestamp
                    //yase registro el usuario como disponible , luego empieza una segunda query
                    //2. get  5 usuarios por partida .
                    //obtener los ultimos 5 usuarios donde status y tiemestamp son similares
                    //enviarles una solicitud con el uid de la mesa si la aceptan pasan a esa mesa
                    //3. si la aceptan cambia su estado a of y son enviados a la plantilla con el numero de la mesa

                    /* Navigator.pushNamed(context, "playdados",
                        arguments: materiaslist[index].idMaterias.toString());*/

                    //  Navigator.pushNamed(context, "detalle",
                    //    arguments: materiaslist[index]);
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          child: FadeInImage(
                            image: NetworkImage(materiaslist[index]
                                .getposterimage()), // peliculas_list[index].getposterimage()
                            placeholder: AssetImage('assets/no-image.png'),
                            fit: BoxFit
                                .cover, //reparo el error del controno medio ciruclar
                          ),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.topCenter,
                          color: Colors.white38,
                          child: ClipRRect(
                            //clip reect para poner el border y dento ponemos la imagen
                            borderRadius: BorderRadius.circular(20),
                            child: Text(
                              materiaslist[index].materia,
                              //textScaleFactor: 24,
                              textScaleFactor: 2.5,

                              overflow: TextOverflow
                                  .ellipsis, //cuando el texto no cabe pone puntitos
                              style: Theme.of(context).textTheme.caption,
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
                              materiaslist[index].descripcion,
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
                )),
          );
        },
        itemCount: materiaslist.length, //3,
        //pagination:    new SwiperPagination(), //viene por defecto es para mostrar los puntitos de abajo para paginar
        control:
            new SwiperControl(), //viene por defecto para mover hacia los ladors
      ),
    );
  }
}
*/