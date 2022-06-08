import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerAlamat = new TextEditingController();
  TextEditingController controllerNoHP = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  void kirimdata() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Container(
        height: 200.0,
        child: new Column(
          children: <Widget>[
            new Text("Nama\t: ${controllerNama.text}"),
            new Text("Alamat\t: ${controllerAlamat.text}"),
            new Text("No HP\t: ${controllerNoHP.text}"),
            new Text("Email\t: ${controllerEmail.text}"),
            new Text("Password\t: ${controllerPassword.text}"),
          ],
        ),
      ),
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new Icon(Icons.list),
        title: new Text("Register"),
        backgroundColor: Colors.teal,
      ),
      body: new ListView(
        padding: new EdgeInsets.all(10.0),
        children: [
          new Column(
            children: <Widget>[
              new TextField(
                controller: controllerNama,
                decoration: new InputDecoration(
                    hintText: "Nama",
                    labelText: "Nama",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.horizontal())),
              ),
              new Padding(padding: EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerAlamat,
                decoration: new InputDecoration(
                    hintText: "Alamat",
                    labelText: "Alamat",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.horizontal())),
              ),
              new Padding(padding: EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerNoHP,
                decoration: new InputDecoration(
                    hintText: "No HP",
                    labelText: "No HP",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.horizontal())),
              ),
              new Padding(padding: EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerEmail,
                decoration: new InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.horizontal())),
              ),
              new Padding(padding: EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerPassword,
                obscureText: true,
                decoration: new InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.horizontal())),
              ),
              new Padding(padding: EdgeInsets.only(top: 20.0)),
            ],
          ),
          new RaisedButton(
            child: new Text("Register"),
            onPressed: () {
              kirimdata();
            },
          ),
        ],
      ),
    );
  }
}
