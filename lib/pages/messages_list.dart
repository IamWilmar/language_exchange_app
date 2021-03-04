import 'package:flutter/material.dart';
import 'package:language_exchange_app/models/mensajes_response.dart';
import 'package:language_exchange_app/models/usuario_model.dart';
import 'package:language_exchange_app/services/auth_service.dart';
import 'package:language_exchange_app/services/mensajes_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagesListPage extends StatefulWidget {
  final Usuario user;
  const MessagesListPage({Key key, this.user}) : super(key: key);
  @override
  _MessagesListPageState createState() => _MessagesListPageState();
}

class _MessagesListPageState extends State<MessagesListPage> {
  List<Mensaje> mensajes = [];
  RefreshController _refreshMessageController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    this._cargarMensajes();
    super.initState();
  }

  @override
  void dispose() {
    this._refreshMessageController.dispose();
    super.dispose();
  }

  _cargarMensajes() async {
    this.mensajes = await MensajesService.getMessages(widget.user.uid);
    setState(() {});
    // await Future.delayed(Duration(seconds: 20));
    // if failed,use refreshFailed()
    _refreshMessageController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SmartRefresher(
        controller: _refreshMessageController,
        onRefresh: this._cargarMensajes,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.black),
          waterDropColor: Colors.black,
        ),
        child: _messagesList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF592252),
        child: Icon(Icons.mail_outline_rounded),
        onPressed: () {
          Navigator.pushNamed(context, 'writePage', arguments: widget.user);
        },
      ),
    );
  }

  Widget _messagesList() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: this.mensajes.length,
      itemBuilder: (_, i) => MessagesTile(mensaje: this.mensajes[i]),
      separatorBuilder: (_, i) => Container(
        color: Colors.grey.withOpacity(0.2),
        height: 1,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}

class MessagesTile extends StatelessWidget {
  final Mensaje mensaje;
  const MessagesTile({Key key, @required this.mensaje}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return ListTile(
      tileColor:
          (mensaje.de == authService.usuario.uid) ? Color(0xFF592252) : null,
      title: Text(
        mensaje.titulo,
        style: TextStyle(
          fontSize: 18,
          color: (mensaje.de == authService.usuario.uid)
              ? Colors.white
              : Colors.black,
        ),
      ),
      subtitle: Text(
        mensaje.carta,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: ((mensaje.de == authService.usuario.uid)
                ? Colors.grey.shade400
                : Colors.grey)),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'readPage', arguments: mensaje);
      },
    );
  }
}
