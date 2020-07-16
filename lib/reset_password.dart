import 'package:flutter/material.dart';


class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperação de senha"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Builder(builder: (context){
        return Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 200,
              child: Icon(Icons.alternate_email,size: 125.0, color: Colors.red[800]),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Esqueceu sua senha?",
              style: TextStyle(
                fontSize: 32               
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Por favor, informe seu E-mail associado a sua conta que enviaremos um link para o mesmo com as instruções para recuperação da sua senha!",
              style: TextStyle(
                fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20
            ),
            TextFormField(keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(color: Colors.black38,
                fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: RaisedButton(onPressed: (){
                SnackBar mysnackbar = SnackBar(content: Text("Mensagem enviada com sucesso!!"));
                Scaffold.of(context).showSnackBar(mysnackbar);
              },
        child: Text("Enviar",style: TextStyle(color: Colors.white,fontSize: 35.0),),
        color: Colors.blue[900],
        ),
            ),
          ],
          ),
      );
      })
    );
  }
}

 