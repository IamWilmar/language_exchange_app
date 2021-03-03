import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:language_exchange_app/global/enviroment.dart';
import 'package:language_exchange_app/models/mensajes_response.dart';
import 'package:language_exchange_app/services/auth_service.dart';

class MensajesService {
  static Future<List<Mensaje>> getMessages(String userId) async {
    try {
      final resp = await http.get(
        '${Enviroment.apiUrl}/mensajes/$userId',
        headers: ({
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }),
      );
      final mensajesResp = mensajesResponseFromJson(resp.body);
      print(resp.body);
      return mensajesResp.mensajes;
    } catch (error) {
      return [];
    }
  }

  Future<void> sendMessage(Mensaje message) async {
    try {
      final resp = await http.post(
        '${Enviroment.apiUrl}/mensajes/new',
        body: (jsonEncode({
          'de': message.de,
          'para': message.para,
          'titulo': message.titulo,
          'carta': message.carta
        })),
        headers: ({
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }),
      );
      print(resp.body);
    } catch (error) {
      print('error');
    }
  }
}
