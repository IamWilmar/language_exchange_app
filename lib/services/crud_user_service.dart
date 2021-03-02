import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:language_exchange_app/global/enviroment.dart';
import 'package:language_exchange_app/models/usuario_model.dart';

class CrudUserService {
  //Edit User
  Future editUser(String id, Usuario user, String token) async {
    final userData = user.toJson();
    final resp = await http.patch(
      '${Enviroment.apiUrl}/edit/$id',
      body: jsonEncode(userData),
      headers: {
        'Content-Type':'application/json',
        'x-token':token
      },
    );
    print(resp.body);
  }
}
