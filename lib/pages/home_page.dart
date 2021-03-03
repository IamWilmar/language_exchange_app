import 'package:flutter/material.dart';
import 'package:language_exchange_app/pages/contacts_page.dart';
import 'package:language_exchange_app/pages/my_profile_page.dart';
import 'package:language_exchange_app/pages/users_page.dart';
import 'package:language_exchange_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              UsersPage(),
              ContactPage(),
              MyProfilePage(cacheUser: authService.usuario),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: kToolbarHeight,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF592252),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.public,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onTap: (){
                        _pageController.jumpToPage(0);
                      },
                    ),
                    InkWell(
                      child: Icon(
                        Icons.search_sharp,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Icon(
                        Icons.people_outline,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        _pageController.jumpToPage(1);
                      },
                    ),
                    InkWell(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: FadeInImage(
                            width: 30,
                            height: 30,
                            placeholder: AssetImage('assets/paperbag.png'),
                            fit: BoxFit.cover,
                            image: authService.usuario.photo.length > 4
                                ? NetworkImage(authService.usuario.photo)
                                : AssetImage('assets/paperbag.png'),
                          ),
                        ),
                      ),
                      onTap: () {
                        _pageController.jumpToPage(2);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
