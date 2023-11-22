import 'dart:convert';
import 'package:appventas/update_record.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewData extends StatefulWidget {
  ViewData({Key? key}) : super(key: key);

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userData = [];

  Future<void> getRecords() async {
    String uri = "http://localhost/ProjectVentas/view_data.php";

    try {
      var response = await http.get(Uri.parse(uri));
      print(response); // Imprimimos la respuesta completa en la consola
      setState(() {
        // Mapear la respuesta para mostrar solo numeroprestamo e importe
        userData = jsonDecode(response.body).map((record) {
          return {
            "numeroprestamo": record["numeroprestamo"],
            "importe": record["importe"],
          };
        }).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Préstamos Registrados",
          
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          
        ),
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          // Usando Card para mostrar los datos
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
 // Icono para representar un préstamo
              title: Text(
                userData[index]["numeroprestamo"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                userData[index]["importe"],
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: const Color.fromARGB(255, 170, 98, 92),
                    ),
                    onPressed: () {
                      delrecord(userData[index]["numeroprestamo"]);
                      getRecords();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 46, 155, 86),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => update_record(
                            userData[index]["numeroprestamo"],
                            userData[index]["importe"],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> delrecord(String numeroprestamo) async {
    try {
      String uri = "http://localhost/ProjectVentas/delete_record.php";
      var res = await http.post(Uri.parse(uri), body: {"numeroprestamo": numeroprestamo});
      
      // Imprime el cuerpo de la respuesta para debug
      print('Respuesta del servidor: ${res.body}');
      
      var response = json.decode(res.body);

      if (response["success"] == "true") {
        print("Registro borrado");
      } else {
        print("Algun problema");
      }
    } catch (e) {
      print('Error al borrar el registro: $e');
    }
  }
}
