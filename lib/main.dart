import 'package:automics/view/cadastro.dart';
import 'package:automics/view/inicial.dart';
import 'package:automics/view/login.dart';
import 'package:automics/view/bottomenu/menu.dart';
import 'package:automics/view/sobre.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main() async {
  //
  // INICIALIZAR OS Plugins
  //
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automics',

      // TEMAS
      theme: ThemeData(
        primaryColor: Color(0xFF00778D),
        backgroundColor: Color(0xFFC4C4C4),

        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFF00778D),
          selectionColor: Color(0xFF00778D),
        ),
        
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 200,
          ),
        ),
      ),

      //rotas de navegação
      initialRoute: 'menu',
      routes: {
        'inicio': (context) => Inicial(),
        'login': (context) => Login(),
        'cadastro': (context) => Cadastro(),
        'menu': (context) => Menu(),
        'sobre': (context) => Sobre(),
      },
    ),
  );
}