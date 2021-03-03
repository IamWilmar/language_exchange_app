import 'package:flutter/material.dart';
import 'package:language_exchange_app/animations/page_transitions.dart';
import 'package:language_exchange_app/pages/home_page.dart';
import 'package:language_exchange_app/pages/login_page.dart';
import 'package:language_exchange_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      Navigator.pushReplacement(
        context,
        goToPage(HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        goback(LogInPage()),
      );
    }
  }
}
