import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:language_exchange_app/global/enviroment.dart';
import 'package:language_exchange_app/models/login_response.dart';
import 'package:language_exchange_app/models/usuario_model.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  //crear storage para token
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool autenticando) {
    this._autenticando = autenticando;
    notifyListeners();
  }

  //Getter y setter del token
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  //Interacciones con el almacenamiento de token
  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  //Login method
  Future<bool> login(String email, String password) async {
    this.autenticando = true;
    final logInData = {'email': email, 'password': password};
    final resp = await http.post('${Enviroment.apiUrl}/login',
        body: jsonEncode(logInData),
        headers: {'Content-Type': 'application/json'});
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  //Registro del usuario
  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final registerData = {
      'nombre': nombre,
      'email': email,
      'password': password
    };
    final resp = await http.post('${Enviroment.apiUrl}/login/new',
        body: jsonEncode(registerData),
        headers: {'Content-Type': 'application/json'});
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final registerResponse = loginResponseFromJson(resp.body);
      this.usuario = registerResponse.usuario;
      this._guardarToken(registerResponse.token);
      return true;
    } else {
      return false;
    }
  }

  //SI token todavia es valido, Renueva el token
  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final resp = await http.get(
      '${Enviroment.apiUrl}/login/renew',
      headers: {'Content-Type': 'application/json', 'x-token': token}
    );
    if(resp.statusCode == 200){
      final isloggedResponse = loginResponseFromJson(resp.body);
      this.usuario = isloggedResponse.usuario;
      await this._guardarToken(isloggedResponse.token);
      return true;
    }else{
      this.logout();
      return false;
    }
  }
}
