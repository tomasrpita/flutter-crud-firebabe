import 'package:flutter/material.dart';
import 'package:crudfirebase/src/pages/bloc/login_bloc.dart';
export 'package:crudfirebase/src/pages/bloc/login_bloc.dart';

// Vas a ser mi in personalizado
// Puede llamarse de diferente forma,
// puede manejar varios bloc
class Provider extends InheritedWidget {
  // Implementar la clase como singleton para prevenir la perdida de la data
  // cuando hacemos un hot reload
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  final loginBloc = LoginBloc();

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  // en la mayoria de los casos vamos a que querer que haga notificación
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}
