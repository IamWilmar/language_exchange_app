import 'package:flutter/material.dart';
import 'package:language_exchange_app/pages/loading_page.dart';
import 'package:language_exchange_app/pages/login_page.dart';
import 'package:language_exchange_app/pages/messages_list.dart';
import 'package:language_exchange_app/pages/my_profile_page.dart';
import 'package:language_exchange_app/pages/profile_page.dart';
import 'package:language_exchange_app/pages/read_letter_page.dart';
import 'package:language_exchange_app/pages/register_page.dart';
import 'package:language_exchange_app/pages/users_page.dart';
import 'package:language_exchange_app/pages/write_letter_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login'         : (_) => LogInPage(),
  'register'      : (_) => RegisterPage(),
  'users'         : (_) => UsersPage(),
  'loading'       : (_) => LoadingPage(),
  'profile'       : (_) => ProfilePage(),
  'myProfile'     : (_) => MyProfilePage(),
  'messagesList'  : (_) => MessagesListPage(),
  'readPage'      : (_) => ReadLetterPage(),
  'writePage'     : (_) => WriteLetterPage(),
};