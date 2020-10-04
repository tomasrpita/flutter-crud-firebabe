import 'package:flutter/material.dart';
import 'package:crudfirebase/src/utils/utils.dart' as utils;

class ProductPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              children: [_crearNombre(), _crearPrecio(), _crearBoton()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      validator: (value) =>
          value.length > 3 ? null : 'ingrese el nombre del producto',
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
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
  }
}
