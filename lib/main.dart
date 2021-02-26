import 'package:flutter/material.dart';
import 'package:language_exchange_app/providers/edit_user_provider.dart';
import 'package:language_exchange_app/routes/routes.dart';
import 'package:language_exchange_app/services/auth_service.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => EditUser()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bonds',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}