import 'package:flutter/material.dart';
import 'package:gelir_gider_mobil_app/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gelir Gider Uygulaması',
      color: Colors.blueGrey,
      home: AnaEkran(),
    );
  }
}
