import 'dart:convert';

import 'package:crudfirebase/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  final _url = 'https://flutter-varios-8ac0b.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    print(decodeData);
    return true;
  }
}
