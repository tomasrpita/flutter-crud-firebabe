import 'package:crudfirebase/src/provider/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:crudfirebase/src/bloc/provider.dart';
import 'package:crudfirebase/src/models/producto_model.dart';

class HomePage extends StatelessWidget {
  final productosProvider = new ProductosProvider();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
        ),
        onPressed: () => Navigator.pushNamed(context, 'producto'));
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, i) => _crearItem(context, productos[i]));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        // TODO: borrar Producto
      },
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text('${producto.id}'),
        onTap: () => Navigator.pushNamed(context, 'producto'),
      ),
    );
  }
}
