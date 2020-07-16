import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gerenciadorbusca/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
  testeCRUD();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Welcome(),
    );
  }
}

// async = assíncrono
void testeCRUD() async {
  //criar uma instância do Firestore
  final db = Firestore.instance;
  String nome = "alunos";
}

class Firestore {
  static var instance;
}
