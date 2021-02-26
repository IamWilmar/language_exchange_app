import 'package:flutter/material.dart';
import 'package:language_exchange_app/models/usuario_model.dart';

class ProfilePage extends StatelessWidget {
  final Usuario user;
  const ProfilePage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final Usuario user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFECEBE9),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xFF592252),
            floating: true,
            expandedHeight: 500,
            flexibleSpace: FlexibleSpaceBar(
              background: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/paperbag.png'),
                fadeInDuration: Duration(seconds: 10),
                image: (user.photo.length > 4)
                    ? NetworkImage(user.photo)
                    : AssetImage('assets/paperbag.png'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              CustomUserName(user: user),
              CustomDivider(),
              UserBio(user: user),
            ]),
          ),
        ],
      ),
    );
  }
}

class CustomUserName extends StatelessWidget {
  final Usuario user;
  final TextStyle nameStyle = TextStyle(
    fontSize: 50,
    color: Colors.grey[200],
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );
  CustomUserName({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF592252),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(user.nombre, style: nameStyle),
    );
  }
}

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      decoration: BoxDecoration(
        color: Color(0xFF592252),
      ),
    );
  }
}

class UserBio extends StatelessWidget {
  final Usuario user;
  UserBio({Key key, @required this.user}) : super(key: key);
  final TextStyle bioTitleStyle = TextStyle(
    fontSize: 30,
    color: Colors.grey[600],
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );
  final TextStyle bioTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.grey[800],
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFECEBE9),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bio', style: bioTitleStyle),
          SizedBox(height: 30),
          Text(user.biography, style: bioTextStyle, textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}

class _Boxes extends StatelessWidget {
  final color;
  const _Boxes(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 100,
      color: color,
    );
  }
}
