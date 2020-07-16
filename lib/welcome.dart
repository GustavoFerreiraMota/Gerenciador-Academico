import 'package:flutter/material.dart';
import 'package:gerenciador_academico/first.dart';
import 'package:gerenciador_academico/second.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bem-vindo ao GTA'),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(5.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.accessibility_new,
                  size: 50.0,
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 170,
                        height: 40,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FirstPage()));
                          },
                          child: Text(
                            'Já tenho conta',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          color: Colors.blue[900],
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 170,
                        height: 40,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondPage()));
                          },
                          child: Text(
                            'Criar conta',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
