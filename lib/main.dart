import 'package:crudfirebase/src/pages/produdcto_page.dart';
import 'package:flutter/material.dart';
import 'package:crudfirebase/src/bloc/provider.dart';
import 'package:crudfirebase/src/pages/home_page.dart';
import 'package:crudfirebase/src/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Form Validation - Bloc',
          initialRoute: 'home',
          routes: {
            'login': (BuildContext context) => LoginPage(),
            'home': (BuildContext context) => HomePage(),
            'producto': (BuildContext context) => ProductPage(),
          },
          theme: ThemeData(primaryColor: Colors.deepPurple)),
    );
  }
}
