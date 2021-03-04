import 'package:flutter/material.dart';
import 'package:language_exchange_app/animations/page_transitions.dart';
import 'package:language_exchange_app/pages/loading_page.dart';
import 'package:language_exchange_app/pages/my_profile_page.dart';
import 'package:language_exchange_app/pages/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:language_exchange_app/models/usuario_model.dart';
import 'package:language_exchange_app/services/auth_service.dart';
import 'package:language_exchange_app/services/usuarios_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>  with AutomaticKeepAliveClientMixin{
  final usuariosService = UsuariosService();
  List<Usuario> usuarios = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  void dispose() { 
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Meeting', style: TextStyle(color: Colors.grey)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthService.deleteToken();
              Navigator.of(context).pushReplacement(goback(LoadingPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.black),
            waterDropColor: Colors.black,
          ),
          child: _userList(),
        ),
      ),
    );
  }

  //Es necesario que se mantenga dentro de la clase donde
  //se encuentra en refresher
  Widget _userList() {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: kToolbarHeight),
      physics: BouncingScrollPhysics(),
      itemCount: this.usuarios.length,
      itemBuilder: (_, i) => UserTile(user: this.usuarios[i]),
      separatorBuilder: (_, i) => SizedBox(height: 15),
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuariosService.getUsuarios();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key key,
    @required this.authService,
  }) : super(key: key);

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    final cacheUser = Provider.of<AuthService>(context);
    return InkWell(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: FadeInImage(
            width: 40,
            height: 40,
            placeholder: AssetImage('assets/paperbag.png'),
            fit: BoxFit.cover,
            image: authService.usuario.photo.length > 4
                ? NetworkImage(authService.usuario.photo)
                : AssetImage('assets/paperbag.png'),
          ),
        ),
      ),
      onTap: () {
        print(cacheUser.usuario.learnLanguage);
        Navigator.of(context).push(goToPage(MyProfilePage(cacheUser: cacheUser.usuario)));
      },
    );
  }
}

class UserTile extends StatelessWidget {
  final Usuario user;
  UserTile({Key key, this.user}) : super(key: key);
  final TextStyle nameStyle = TextStyle(
      color: Colors.grey[200], fontWeight: FontWeight.w400, fontSize: 20);
  final TextStyle ageStyle = TextStyle(
      color: Colors.grey[400], fontWeight: FontWeight.w400, fontSize: 14);
  final TextStyle bioStyle = TextStyle(
      color: Colors.grey[800], fontWeight: FontWeight.w400, fontSize: 17);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 5),
        child: InkWell(
          onTap: () {
            Navigator.push(context, goToPage(ProfilePage(user: user)));
          },
          child: Row(
            children: [
              _userPhoto(context),
              _userInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _userPhoto(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        color: Colors.grey[400],
        child: Hero(
          tag: "${user.uid}",
          child: FadeInImage(
            placeholder: AssetImage('assets/paperbag.png'),
            height: 200,
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 200),
            image: user.photo.length > 4
                ? NetworkImage(user.photo)
                : AssetImage('assets/paperbag.png'),
          ),
        ),
      ),
    );
  }

  Expanded _userInfo(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userBasicInfo(),
            Divider(),
            _bio(),
          ],
        ),
      ),
    );
  }

  Container userBasicInfo() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Color(0xFF592252),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            user.nombre,
            style: this.nameStyle,
            overflow: TextOverflow.visible,
            maxLines: 1,
          ),
          Text('${user.age} years old', style: ageStyle),
        ],
      ),
    );
  }

  Container _bio() {
    return Container(
      child: Text(
        user.biography,
        maxLines: 4,
        overflow: TextOverflow.fade,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        style: bioStyle,
      ),
    );
  }
}
