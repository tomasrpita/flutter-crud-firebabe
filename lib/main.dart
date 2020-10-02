import 'package:flutter/material.dart';
import 'package:crudfirebase/src/pages/bloc/provider.dart';
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
          initialRoute: 'login',
          routes: {
            'login': (BuildContext context) => LoginPage(),
            'home': (BuildContext context) => HomePage(),
          },
          theme: ThemeData(primaryColor: Colors.deepPurple)),
    );
  }
}
