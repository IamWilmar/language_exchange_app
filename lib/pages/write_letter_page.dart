import 'package:flutter/material.dart';
import 'package:language_exchange_app/models/mensajes_response.dart';
import 'package:language_exchange_app/models/usuario_model.dart';
import 'package:language_exchange_app/services/auth_service.dart';
import 'package:language_exchange_app/services/mensajes_service.dart';
import 'package:provider/provider.dart';

class WriteLetterPage extends StatefulWidget {
  @override
  _WriteLetterPageState createState() => _WriteLetterPageState();
}

class _WriteLetterPageState extends State<WriteLetterPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  @override
  @override
  void initState() {
    _titleController.text = "";
    _contentController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Usuario user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF592252),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _titleNote(),
              _contentNote(context),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: (_titleController.text.trim().length <= 0 ||
                _contentController.text.trim().length <= 0)
            ? Colors.grey
            : Color(0xFF592252),
        child: Icon(Icons.send_sharp),
        onPressed: (_titleController.text.trim().length <= 0 ||
                _contentController.text.trim().length <= 0)
            ? null
            : () async {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                final mensajeService = MensajesService();
                setState(() {});
                Mensaje mensaje = Mensaje(
                  titulo: _titleController.text,
                  carta: _contentController.text,
                  de: authService.usuario.uid,
                  para: user.uid,
                );
                await mensajeService.sendMessage(mensaje);
                Navigator.pop(context);
              },
      ),
    );
  }

  _titleNote() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          decoration: InputDecoration(hintText: 'Title .... :)'),
          onChanged: (title) {
            _titleController.text = title;
            setState(() {});
          }),
    );
  }

  _contentNote(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        child: TextFormField(
          decoration:
              InputDecoration(hintText: 'Type something nice here.... :)'),
          minLines: 200,
          maxLines: null,
          onChanged: (note) {
            _contentController.text = note;
            setState(() {});
          },
        ),
      ),
    );
  }
}
