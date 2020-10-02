import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:crudfirebase/src/pages/bloc/validators.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  // la libreria de rx que estamos usando más abajo no admite los StreamController
  // por eso hemos cambiado a BehaviorSubject, el metodo broadcast ya viene
  // implicito
  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();

  // REcuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Una de las ventajas de BehaviorSubjetc sobre los Stream controller
  // es que ya tienen un metodo que nos da el valor del ultimo stream
  // vamos a crear unos getters para obtener nuestros valores
  // Obtener ultimo valor ingresado del los treams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
