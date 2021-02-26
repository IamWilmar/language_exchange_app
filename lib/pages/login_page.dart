import 'package:flutter/material.dart';
import 'package:language_exchange_app/helpers/mostrar_alerta.dart';
import 'package:language_exchange_app/services/auth_service.dart';
import 'package:language_exchange_app/widgets/boton_azul.dart';
import 'package:language_exchange_app/widgets/custom_input.dart';
import 'package:language_exchange_app/widgets/labels.dart';
import 'package:provider/provider.dart';


class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Logo(),
                _Form(),
                Labels(
                    route: 'register',
                    titulo: '¿No tienes Cuenta?',
                    subTitulo: 'Crea una ahora'),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.email_outlined,
            textController: emailController,
            keyboardType: TextInputType.emailAddress,
            hint: 'Email',
          ),
          CustomInput(
            icon: Icons.text_format,
            textController: passController,
            keyboardType: TextInputType.text,
            isPassword: true,
            hint: 'Password',
          ),
          BlueButton(
            text: 'Log In',
            onPressed: (emailController.text.isEmpty || passController.text.isEmpty) ? null : () async {
              FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService>(context, listen: false);
              final isloginOk = await authService.login(emailController.text.trim(), passController.text.trim());
              if(isloginOk){
                Navigator.pushReplacementNamed(context, 'loading');
              }else{
                //Mostrar alerta
                mostrarAlerta(context, 'Login Incorrecto', 'Credenciales no validas');
              }
            },
          ),
        ],
      ),
    );
  }
}