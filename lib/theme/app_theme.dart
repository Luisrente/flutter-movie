import 'package:flutter/material.dart';

class AppTheme {
  // static const porque no va a cambiar desde el momento de la  ejecucion
  static const Color primary = Colors.indigo;

  //Static final por que la instancia por eso no puede ser const porque la instancia se genera

  static final ThemeData ligthTheme = ThemeData.light().copyWith(

      //Color primario
      primaryColor: Colors.indigo,

      //AppBar Theme
      appBarTheme: const AppBarTheme(color: primary, elevation: 0));
}
