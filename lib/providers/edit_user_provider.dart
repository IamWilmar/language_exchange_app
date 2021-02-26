import 'package:flutter/material.dart';
import 'package:language_exchange_app/models/usuario_model.dart';

class EditUser with ChangeNotifier{
  Usuario _user = new Usuario();
  Usuario get user => this._user;

  set user(Usuario user) {
    this._user = user;
    notifyListeners();
  }
}