import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appventas/viewusers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>(); // Agrega una clave global para Scaffold

  Future<void> insertrecord() async {
    if (name.text.isNotEmpty && email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        String uri = "http://localhost/ProjectVentas/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text,
          "password": password.text
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Registro insertado");
        } else {
          print("Algo salió mal");
        }
      } catch (e) {
        print(e);
      }
      name.text = "";
      email.text = "";
      password.text = "";
    } else {
      print("Por favor, llene todos los campos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 231, 108, 149), // Cambia el color primario a rosa
      ),
      home: Scaffold(
        key: scaffoldKey, // Asigna la clave global a Scaffold
        appBar: AppBar(
          title: Text('REGISTRAR CLIENTE'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese el nombre',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese la calle',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese la ciudad',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  insertrecord();
                },
                child: Text('Insertar'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewData()),
                      );
                    },
                    child: Text("Mostrar"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}