import 'package:flutter/material.dart';
import 'package:gerenciador_academico/welcome.dart';
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
      //initialRoute: "/welcome",
      //routes: {"/welcome": (context) => Welcome(),}
      
    );
  }
}
// CRUD: Flutter + Firebase
//
// async = assíncrono
void testeCRUD() async {
  //criar uma instância do Firestore
  final db = Firestore.instance;
  String nome = "alunos";

  //criar uma coleção e um documento
  
  db.collection(nome).document("123456")
  .setData({
    "loguin": "João da Silva",
    "senha": "Análise de Desenvolvimento de Sistemas",
   
  });
  

  //criar um documento com ID automático
  
  DocumentReference id = await db.collection(nome)
    .add(
      {
        "nome": "Ana Maria",
        "curso": "Análise de Desenvolvimento de Sistemas",
        "ano": 2020
      }
    );
  //exibir o ID gerado pelo Firestore
  print("ID: " + id.documentID);
  

  //listar todos os documentos
  await db.collection(nome).getDocuments()
    .then((QuerySnapshot res){

      res.documents.forEach((doc) {
        print("ID..: ${doc.documentID}");
        print("Data: ${doc.data}");
      });

    });

  //Recuperar um único documento
  
  DocumentSnapshot doc = await db.collection(nome)
  .document("123456").get();
  print("ID..: ${doc.documentID}");
  print("Data: ${doc.data}");

  //Atulização de um documento
  
  await db.collection(nome).document("123456")
  .updateData({
    "nome": "Thiago Valle",
    "ano": 2015
  });

  //Apagar um documento
  
  //db.collection(nome).document("123456").delete();
  

  //NOTIFICAÇÕES
  //Exibir os documentos da coleção toda vez que
  // alguma alteração for realizada;
  
  db.collection(nome).snapshots().listen((event) {
    print("-------------");
    print("ATUALIZAÇÃO");
    print("-------------\n");
    event.documents.forEach((doc) {
      print("Data: ${doc.data}\n");
    });
  });
}

