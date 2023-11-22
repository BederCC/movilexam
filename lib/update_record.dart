import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class update_record extends StatefulWidget {
  String numeroprestamo;
  String importe;
  update_record(this.numeroprestamo, this.importe);

  @override
  State<update_record> createState() => _update_recordState();
}

class _update_recordState extends State<update_record> {
  TextEditingController numeroprestamo = TextEditingController(); 
  TextEditingController importe = TextEditingController();

  Future<void> updaterecord() async {
    try {
      String uri = "http://localhost/ProjectVentas/update_record.php";
      var res = await http.post(Uri.parse(uri), body: {
        "numeroprestamo": numeroprestamo.text,
        "importe": importe.text,
      });

      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Update");
      } else {
        print("No Update");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    importe.text = widget.importe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ACTUALIZAR REGISTRO"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: importe,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingrese el importe',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                updaterecord();
              },
              child: Text('Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}
