import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  TextEditingController controllerNoHP = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  void kirimdata() {
    AlertDialog alertDialog = AlertDialog(
      content: SizedBox(
        height: 200.0,
        child: Column(
          children: <Widget>[
            Text("Nama\t: ${controllerNama.text}"),
            Text("Alamat\t: ${controllerAlamat.text}"),
            Text("No HP\t: ${controllerNoHP.text}"),
            Text("Email\t: ${controllerEmail.text}"),
            Text("Password\t: ${controllerPassword.text}"),
          ],
        ),
      ),
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.list),
        title: const Text("Register"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Column(
            children: <Widget>[
              TextField(
                controller: controllerNama,
                decoration: const InputDecoration(
                    hintText: "Nama",
                    labelText: "Nama",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal())),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextField(
                controller: controllerAlamat,
                decoration: const InputDecoration(
                    hintText: "Alamat",
                    labelText: "Alamat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal())),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextField(
                controller: controllerNoHP,
                decoration: const InputDecoration(
                    hintText: "No HP",
                    labelText: "No HP",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal())),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextField(
                controller: controllerEmail,
                decoration: const InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal())),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              TextField(
                controller: controllerPassword,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal())),
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
            ],
          ),
          RaisedButton(
            child: const Text("Register"),
            color: const Color.fromARGB(255, 92, 201, 241),
            onPressed: () {
              kirimdata();
            },
          ),
        ],
      ),
    );
  }
}
