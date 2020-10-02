import 'package:flutter/material.dart';
import 'package:crudfirebase/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(),
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
}
