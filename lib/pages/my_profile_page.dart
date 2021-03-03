import 'package:flutter/material.dart';
import 'package:language_exchange_app/helpers/language_list.dart';
import 'package:language_exchange_app/models/usuario_model.dart';
import 'package:language_exchange_app/services/auth_service.dart';
import 'package:language_exchange_app/services/crud_user_service.dart';

class MyProfilePage extends StatefulWidget {
  final Usuario cacheUser;
  const MyProfilePage({Key key, this.cacheUser}) : super(key: key);
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Usuario editUser = new Usuario();
  final TextStyle nameStyle = TextStyle(
    fontSize: 50,
    color: Colors.grey[200],
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );

  @override
  void initState() {
    editUser.learnLanguage = widget.cacheUser.learnLanguage;
    editUser.speakLanguage = widget.cacheUser.speakLanguage;
    editUser.age = widget.cacheUser.age;
    editUser.nombre = widget.cacheUser.nombre;
    editUser.biography = widget.cacheUser.biography;
    editUser.email = widget.cacheUser.email;
    editUser.uid = widget.cacheUser.uid;
    editUser.photo = widget.cacheUser.photo;
    editUser.gender = widget.cacheUser.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                image: (widget.cacheUser.photo.length > 4)
                    ? NetworkImage(widget.cacheUser.photo)
                    : AssetImage('assets/paperbag.png'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _customUsername(),
              _customLanguages(context),
              //CustomDivider(),
              //UserBio(),
              _applyChangesButton(),
              SizedBox(
                height: kToolbarHeight,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  _customUsername() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF592252),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(widget.cacheUser.nombre, style: nameStyle),
    );
  }

  _customLanguages(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF592252),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _languageButton(context, this.editUser.speakLanguage, 'speak'),
          _languageButton(context, this.editUser.learnLanguage, 'learn'),
        ],
      ),
    );
  }

  _languageButton(BuildContext context, String language, String type) {
    return InkWell(
      child: Row(
        children: [
          Text(language, style: nameStyle),
          Icon(Icons.edit, size: 40, color: Colors.grey[200].withOpacity(0.5)),
        ],
      ),
      onTap: () => _chooseLanguages(context, type),
    );
  }

  _chooseLanguages(BuildContext context, String languageType) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (_, i) {
            return ListTile(
              title: Text(lista[i]),
              onTap: () {
                if (languageType == 'speak') {
                  this.editUser.speakLanguage = lista[i];
                } else {
                  this.editUser.learnLanguage = lista[i];
                }
                setState(() {});
              },
            );
          },
        );
      },
    );
  }

  _applyChangesButton() {
    return Container(
      child: RaisedButton(
        color: Color(0xFF592252),
        child: Text('Apply Change', style: TextStyle(color: Colors.white)),
        onPressed: (editUser.learnLanguage == widget.cacheUser.learnLanguage &&
                editUser.speakLanguage == widget.cacheUser.speakLanguage)
            ? null
            : () async {
              final crudService = CrudUserService();
              String token = await AuthService.getToken();
              await crudService.editUser(widget.cacheUser.uid, this.editUser, token);
              Navigator.pushReplacementNamed(context, 'loading');
            },
      ),
    );
  }
}

// class ApplyChangesButton extends StatelessWidget {
//   final Usuario editUser;
//   const ApplyChangesButton({Key key, this.editUser}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     //final cacheUser = Provider.of<AuthService>(context);
//     return Container(
//       child: RaisedButton(
//         color: Color(0xFF592252),
//         child: Text('Apply Change', style: TextStyle(color:Colors.white)),
//         onPressed: null,
//       ),
//     );
//   }
// }

// class LanguageButton extends StatelessWidget {
//   final TextStyle nameStyle = TextStyle(
//     fontSize: 50,
//     color: Colors.grey[200],
//     fontWeight: FontWeight.w500,
//     letterSpacing: 1.5,
//   );
//   final String language;
//   final String type;
//   LanguageButton({Key key, this.language, this.type}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Row(
//         children: [
//           Text(language, style: nameStyle),
//           Icon(Icons.edit, size: 40, color: Colors.grey[200].withOpacity(0.5)),
//         ],
//       ),
//       onTap: () => _chooseLanguages(context, type),
//     );
//   }

//   _chooseLanguages(BuildContext context, String languagueType) {
//     return showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return ListView.builder(
//           itemCount: lista.length,
//           itemBuilder: (_, i) {
//             return LanguagueTile(language: lista[i], type: languagueType);
//           },
//         );
//       },
//     );
//   }

// }

// class LanguagueTile extends StatelessWidget {
//   final String language;
//   final String type;
//   const LanguagueTile({
//     Key key,
//     this.language,
//     this.type,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final editUser = Provider.of<EditUser>(context);
//     Usuario newUser = editUser.user;
//     return ListTile(
//       title: Text(language),
//       onTap: () {
//         if (type == 'speak') {
//           newUser.speakLanguage = language;
//         } else {
//           newUser.learnLanguage = language;
//         }
//         editUser.user = newUser;
//       },
//     );
//   }
// }

// class UserBio extends StatelessWidget {
//   final TextStyle bioTitleStyle = TextStyle(
//     fontSize: 30,
//     color: Colors.grey[600],
//     fontWeight: FontWeight.w500,
//     letterSpacing: 1.5,
//   );
//   final TextStyle bioTextStyle = TextStyle(
//     fontSize: 15,
//     color: Colors.grey[800],
//     fontWeight: FontWeight.w500,
//     letterSpacing: 0.1,
//   );
//   @override
//   Widget build(BuildContext context) {
//     final editUser = Provider.of<EditUser>(context, listen: false);
//     return Container(
//       color: Color(0xFFECEBE9),
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text('Bio', style: bioTitleStyle),
//               InkWell(
//                 child: Icon(
//                   Icons.edit,
//                   size: 40,
//                   color: Colors.grey[600].withOpacity(0.5),
//                 ),
//                 onTap: () => _changeBio(context),
//               ),
//             ],
//           ),
//           SizedBox(height: 30),
//           Text(editUser.user.biography,
//               style: bioTextStyle, textAlign: TextAlign.justify),
//         ],
//       ),
//     );
//   }

//   _changeBio(BuildContext context) {
//     final editUser = Provider.of<EditUser>(context, listen: false);
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         final Usuario newUser = editUser.user;
//         return SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).viewInsets.bottom,
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   child: TextFormField(
//                     initialValue: editUser.user.biography,
//                     decoration: InputDecoration(hintText: '...'),
//                     minLines: 5,
//                     maxLines: null,
//                     onChanged: (bio) {
//                       newUser.biography = bio;
//                       editUser.user = newUser;
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class CustomDivider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 5,
//       decoration: BoxDecoration(
//         color: Color(0xFF592252),
//       ),
//     );
//   }
// }
