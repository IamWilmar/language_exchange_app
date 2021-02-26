import 'package:http/http.dart' as http;
import 'package:language_exchange_app/global/enviroment.dart';
import 'package:language_exchange_app/models/usuario_model.dart';
import 'package:language_exchange_app/models/usuarios_response.dart';
import 'package:language_exchange_app/services/auth_service.dart';

class UsuariosService{
   Future<List<Usuario>> getUsuarios() async { 
    try{
      final resp = await http.get('${Enviroment.apiUrl}/usuarios',
        headers: {
          'Content-Type' : 'application/json',
          'x-token': await AuthService.getToken()
        }
      );
      final usuarioResponse = usuariosResponseFromJson(resp.body);
      return usuarioResponse.usuarios;
    }catch(e){
      return [];
    }
  }
}
