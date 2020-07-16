import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class DadosUsuarios {
  //Atributos
  String _nome;
  String _email;
  String _senha;
  String _dtNascimento;

  //Construtor
  DadosUsuarios(this._nome, this._email, this._senha, this._dtNascimento);

  //Getters
  String get nome => _nome;
  String get email => _email;
  String get senha => _senha;
  String get dtNascimento => _dtNascimento;

  DadosUsuarios.map(dynamic obj) {
    this._nome = obj['nome'];
    this._email = obj['email'];
    this._senha = obj['senha'];
    this._dtNascimento = obj['dtNascimento'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["nome"] = _nome;
    map["email"] = _email;
    map["senha"] = _senha;
    map["dtNascimento"] = _dtNascimento;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  DadosUsuarios.fromMap(Map<String, dynamic> map) {
    //Atribuir id ao this.email, somente se id não for
    //nulo, caso contrário atribui '' (vazio).
    this._nome = map["nome"];
    this._email = map["email"];
    this._senha = map["senha"];
    this._dtNascimento = map["dtNascimento"];
  }
}

class SecondPage extends StatelessWidget {
  TextEditingController txtNomeUsuario = new TextEditingController();
  TextEditingController txtemailUsuario = new TextEditingController();
  TextEditingController txtSenhaUsuario = new TextEditingController();
  TextEditingController txtCofirmaSenhaUsuario = new TextEditingController();
  TextEditingController txtNascimento = new TextEditingController();

  final db = Firestore.instance;
  final String colecao = "Usuarios";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.save, size: 125.0, color: Colors.black),
            TextField(
              controller: txtNomeUsuario,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Insira seu nome: ",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            TextField(
              controller: txtemailUsuario,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Insira seu e-mail: ",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            TextField(
              controller: txtSenhaUsuario,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Senha: ",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            TextField(
              controller: txtCofirmaSenhaUsuario,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Confirme sua senha: ",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            TextField(
              controller: txtNascimento,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  labelText: "Insira sua data de nascimento: ",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //MaterialPageRoute(builder: (context) => FirstPage()));
                    DadosUsuarios obj = new DadosUsuarios(
                        txtNomeUsuario.text,
                        txtemailUsuario.text,
                        criptografar(txtSenhaUsuario.text),
                        txtNascimento.text);
                    inserir(context, obj);
                   
                  },
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  color: Colors.blue[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void inserir(BuildContext context, DadosUsuarios dadosUsuario) async {
    await db.collection("Usuarios").document(dadosUsuario.email).setData({
      "nome": dadosUsuario.nome,
      "dtNascimento": dadosUsuario.dtNascimento,
      "senha": dadosUsuario.senha,
    });
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Cadastro realizado com sucesso!"),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  String criptografar(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }
}
