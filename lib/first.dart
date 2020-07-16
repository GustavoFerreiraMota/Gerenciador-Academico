import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_academico/reset_password.dart';
import 'package:gerenciador_academico/third.dart';

class FirstPage extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtSenha = new TextEditingController();

  

  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciador de tarefas"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.school, size: 125.0, color: Colors.black),
              TextField(
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Insira seu e-mail: ",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
              TextField(
                controller: txtSenha,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Senha: ",
                    labelStyle: TextStyle(color: Colors.black)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var busca =
                            db.collection("Usuarios").document(txtEmail.text);
                        busca.get().then((document) {
                          if (document.exists &&
                              document.data["senha"] ==
                                  criptografar(txtSenha.text)) {
                            debugPrint("Sucesso");
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ThirdPage()));
                          } else if (document.exists &&
                              document.data["senha"] !=
                                  criptografar(txtSenha.text)) {
                            debugPrint("Senha incorreta");
                          } else {
                            debugPrint("Email Inválido!");
                          }
                        });
                      } else {
                        debugPrint(
                            "Dados inválidos! Por favor tente novamente.");
                      }
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.blue[900],
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {},
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()));
                    },
                    child: Text(
                      "Esqueceu a asenha?",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String criptografar(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  

}
