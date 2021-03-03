import 'package:flutter/material.dart';
import 'package:language_exchange_app/models/mensajes_response.dart';

class ReadLetterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Mensaje mensaje = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF592252),
        title: Text(mensaje.titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 20),
        child: SingleChildScrollView(
          child: Text(
            mensaje.carta,
            style: TextStyle(fontSize: 17),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
