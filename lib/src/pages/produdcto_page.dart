import 'package:crudfirebase/src/provider/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:crudfirebase/src/models/producto_model.dart';
import 'package:crudfirebase/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final productosProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (newValue) => producto.titulo = newValue,
      validator: (value) =>
          value.length > 3 ? null : 'ingrese el nombre del producto',
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (newValue) => producto.valor = double.parse(newValue),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Sólo se adminten números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: _submit,
        textColor: Colors.white,
        color: Colors.deepPurple,
        icon: Icon(Icons.save),
        label: Text('Guardar'));
  }

  void _submit() {
    // Si no es valido
    if (!formKey.currentState.validate()) return;

    // Todas las instrucciones si es valido
    print('Ok');
    formKey.currentState.save();
    print(producto.titulo);
    print(producto.valor);
    print(producto.disponible);
    if (producto.id == null) {
      productosProvider.crearProducto(producto);
    } else {
      productosProvider.editarProducto(producto);
    }
  }

  _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      onChanged: (newValue) => setState(() {
        producto.disponible = newValue;
      }),
      activeColor: Colors.deepPurple,
    );
  }
}
