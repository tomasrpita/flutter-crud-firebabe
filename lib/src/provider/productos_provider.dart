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

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);

    final List<ProductoModel> productos = new List();
    final Map<String, dynamic> decodeData = json.decode(resp.body);

    if (decodeData == null) return [];

    decodeData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);

      prodTemp.id = id;
      productos.add(prodTemp);
    });

    // print(decodeData);
    print(productos[0].id);

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;
  }
}
