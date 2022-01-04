//aqui haremos las interacciones directas con la based e datos
import 'dart:convert';
import 'dart:io';
import 'package:criptodadosweb/preferencias_usuario/preferences_user.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductosProvider {
  //get put post delente:

  final String _url_bbdd =
      "https://salonhouse-370be-default-rtdb.firebaseio.com/";

  final _pref_user = new PreferenciasUsuario(); //shared preferences

  //  1.insertar un nuevo producto y pasamos solo  el modelo de datos
  // furute reemplaza el valor de algo hasta que obtenga algo

  //-----------API IMAGENES ABAJO------------------//////////////////////////////////////

  //subir imagen y guardarla en firebase
  // //file es literal filas del dispositivo
  Future<String?> subirimagen(File imagen_seleccionada) async {
    final Uri url_BBDD = Uri.parse(
        'https://api.cloudinary.com/v1_1/dyfjvet1m/image/upload?upload_preset=rnjrehli'); //url base de datos de imagenes para agregar imagenes //htttp/keunube/upload

    final mimetype = mime(imagen_seleccionada
        .path); //imagenes/imagen1.jpg obteiene la ruta directa

    final image_upload_Request =
        http.MultipartRequest('POST', url_BBDD); //methodo a la bBBDD post

    //requuiere import 'package:http_parser/http_parser.dart';
    //definimos el archivo : /fila , imagen.path, archivo seleccionado
    final file_img = await http.MultipartFile.fromPath(
        'file', imagen_seleccionada.path,
        contentType: MediaType(
            mimetype![0],
            mimetype[
                1])); //tipo de objeto a enviar una fila  de la imagen seleccionada
    image_upload_Request.files.add(file_img); //1 archivo
    //podemos especificar multples archivos asi
    // image_upload_Request.files.add(file_img); //1
    // image_upload_Request.files.add(file_img); //2

    final streamResponse_1 = await image_upload_Request.send();

    final resp = await http.Response.fromStream(
        streamResponse_1); //respuesta tradiciona con body
    //verificams si la respuesta!=200
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio MAL');
      return null;
    }

    //
    final responsedatata = json.decode(resp.body);
    print(responsedatata["secure_url"]);
    return responsedatata["secure_url"];
  }
}
