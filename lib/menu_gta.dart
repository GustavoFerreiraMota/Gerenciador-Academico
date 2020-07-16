import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:gerenciador_academico/third.dart';
import 'dart:async';

void main() {
  runApp(MenuGTA());
}

class MenuGTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Gerenciador de Tarefas"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThirdPage()));
                },
              )
            ],
            backgroundColor: Colors.blue[900],
          ),
          body: ListaTarefa(),
        ));
  }
}

class Gerenciador {
  //Atributos
  String _tarefa;
  String _data;

  //Construtor
  Gerenciador(this._tarefa, this._data);

  //Getters
  String get tarefa => _tarefa;
  String get data => _data;

  Gerenciador.map(dynamic obj) {
    this._tarefa = obj['tarefa'];
    this._data = obj['data'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["nome"] = _tarefa;
    map["email"] = _data;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Gerenciador.fromMap(Map<String, dynamic> map) {
    //Atribuir id ao this.email, somente se id não for
    //nulo, caso contrário atribui '' (vazio).
    this._tarefa = map["tarefa"];
    this._data = map["data"];
  }
}

class ListaTarefa extends StatefulWidget {
  @override
  _ListaTarefaState createState() => _ListaTarefaState();
}

class _ListaTarefaState extends State<ListaTarefa> {
  List<Gerenciador> lista = [];
  String filtro;

  TextEditingController txtTarefa = new TextEditingController();
  TextEditingController txtData = new TextEditingController();

  final db = Firestore.instance;

  //Stream para "ouvir" o Firebase
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState() {
    super.initState();

    //cancelar o listen, caso a coleção esteja vazia.
    listen?.cancel();

    //retornar dados da coleção e inserir na lista dinâmica
    listen = db.collection("Materias").snapshots().listen((res) {
      setState(() {
        lista =
            res.documents.map((doc) => Gerenciador.fromMap(doc.data)).toList();
      });
    });
  }

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  Widget _itemLista(context, index) {
    return filtro == null || filtro == ""
        ? Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListTile(
                title: Text(
                  lista[index].tarefa,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                subtitle: Text(lista[index].data,
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
          )
        : lista[index].tarefa.toLowerCase().contains(filtro.toLowerCase())
            ? Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListTile(
                    title: Text(
                      lista[index].tarefa,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    subtitle: Text(lista[index].data,
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ),
              )
            : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: TextField(
                  controller: txtTarefa,
                  decoration: InputDecoration(
                      labelText: "Tarefa",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.1,
                        ),
                      )),
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 4,
                child: TextField(
                  controller: txtData,
                  decoration: InputDecoration(
                      labelText: "Data",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.1,
                        ),
                      )),
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.blue[900], size: 30),
                  onPressed: () {
                    setState(() {
                      lista.add(Gerenciador(txtTarefa.text, txtData.text));
                      inserir(
                          context, Gerenciador(txtTarefa.text, txtData.text));
                    });
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.search, color: Colors.blue[900], size: 30),
                  onPressed: () {
                    setState(() {
                      filtro = txtTarefa.text;
                    });
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.remove, color: Colors.blue[900], size: 30),
                  onPressed: () {
                    setState(() {
                      lista.removeAt(0);
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: _itemLista,
            ),
          ),
        ],
      ),
    );
  }

  void inserir(BuildContext context, Gerenciador materia) async {
    await db
        .collection("cafes")
        .add({"tarefa": materia.tarefa, "data": materia.data});
  }

  void _deletar(BuildContext context, DocumentSnapshot doc, int posicao) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text("Tem certeza que deseja excluir?"),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Sim"),
            onPressed: () {
              //deletar o item no Firebase
              db.collection("Materia").document(doc.documentID).delete();

              //atualizar a lista
              setState(() {
                lista.removeAt(posicao);
              });
              Navigator.pop(context);
            },
          ),
          BasicDialogAction(
            title: Text("Não"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
