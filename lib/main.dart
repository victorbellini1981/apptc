import 'package:apptc/src/ui/home/perfil.dart';
import 'package:apptc/src/ui/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Tcc Heart",
    home: Perfil(),
    theme: ThemeData(
      backgroundColor: Color(0xffb22222),
      fontFamily: 'Montserrat',
    ),
  ));
}
