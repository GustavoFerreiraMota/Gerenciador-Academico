import 'package:flutter/material.dart';
import 'package:gerenciador_academico/menu_gta.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Descrição"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuGTA()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                "Desenvolvemos esse projeto para ajudar estudantes a realizarem o gerenciamneto de tarefas e prazos, o que é de extrema necessidade dentro deste cenario de home ofice, aonde os trabalhos avaliativos são mais frequentes.",
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              SizedBox(height: 30),
              Text(
                "O objetivo é conseguir gerenciar a tarefa e prioriza-las por maior complexidade, ou com o prazo menor, para assim conseguir conciliar as tarefas de diversas disciplinas!\n",
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 0.0,
                    height: 100,
                  ),
                  Text(
                    "Desenvolvedores:\n\n            Thierry\n\n",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 0.0,
                  ),
                  Text(
                    " Gustavo",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 190,
                    height: 150,
                    child: Image.asset('assets/imagens/thierry.jpeg'),
                  ),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/imagens/gustavo.jpeg'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
