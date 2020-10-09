import 'package:crudfirebase/src/provider/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:crudfirebase/src/models/producto_model.dart';
import 'package:crudfirebase/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productosProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();

  bool _guardando = false;

  PickedFile foto;

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: () => _procesarImagen(ImageSource.gallery)),
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: () => _procesarImagen(ImageSource.camera))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
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
        onPressed: (_guardando) ? null : _submit,
        textColor: Colors.white,
        color: Colors.deepPurple,
        icon: Icon(Icons.save),
        label: Text('Guardar'));
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  void _submit() async {
    // Si no es valido
    if (!formKey.currentState.validate()) return;

    // Todas las instrucciones si es valido
    print('Ok');
    formKey.currentState.save();
    // print(producto.titulo);
    // print(producto.valor);
    // print(producto.disponible);

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      producto.fotoUrl = await productosProvider.subirImagen(foto);
    }

    if (producto.id == null) {
      productosProvider.crearProducto(producto);
    } else {
      productosProvider.editarProducto(producto);
    }
    mostrarSnackBar('Producto Guardado');
    Navigator.pop(context);
  }

  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    _guardando = false;
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(producto.fotoUrl),
          height: 300.0,
          width: double.infinity,
          fit: BoxFit.contain);
    } else {
      return Image(
        // Si la fotografia tiene un path mostrar ese path sino usa el siguiente
        // valor
        image: AssetImage(foto?.path ?? 'assets/no-image.png'),
        height: 300,
        fit: BoxFit.cover,
      );
    }
  }

  _procesarImagen(ImageSource source) async {
    final _picker = ImagePicker();
    foto = await _picker.getImage(source: source);

    if (foto != null) {
      producto.fotoUrl = null;
    }

    setState(() {});
  }
}
