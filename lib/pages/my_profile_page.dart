import 'package:flutter/material.dart';
import 'package:language_exchange_app/helpers/language_list.dart';
import 'package:language_exchange_app/models/usuario_model.dart';
import 'package:language_exchange_app/providers/edit_user_provider.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final editUser = Provider.of<EditUser>(context);
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
                image: (editUser.user.photo.length > 4)
                    ? NetworkImage(editUser.user.photo)
                    : AssetImage('assets/paperbag.png'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              CustomUserName(),
              CustomLanguages(),
              CustomDivider(),
              UserBio(),
            ]),
          ),
        ],
      ),
    );
  }
}

class CustomUserName extends StatelessWidget {
  final TextStyle nameStyle = TextStyle(
    fontSize: 50,
    color: Colors.grey[200],
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );
  @override
  Widget build(BuildContext context) {
    final editUser = Provider.of<EditUser>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF592252),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(editUser.user.nombre, style: nameStyle),
    );
  }
}

class CustomLanguages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final editUser = Provider.of<EditUser>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF592252),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LanguageButton(language: editUser.user.speakLanguage, type: 'speak'),
          LanguageButton(language: editUser.user.learnLanguage, type: 'learn'),
        ],
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final TextStyle nameStyle = TextStyle(
    fontSize: 50,
    color: Colors.grey[200],
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );
  final String language;
  final String type;
  LanguageButton({Key key, this.language, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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

  _chooseLanguages(BuildContext context, String languagueType) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (_, i) {
            return LanguagueTile(language: lista[i], type: languagueType);
          },
        );
      },
    );
  }

}

class LanguagueTile extends StatelessWidget {
  final String language;
  final String type;
  const LanguagueTile({
    Key key,
    this.language,
    this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final editUser = Provider.of<EditUser>(context);
    Usuario newUser = editUser.user;
    return ListTile(
      title: Text(language),
      onTap: () {
        if (type == 'speak') {
          newUser.speakLanguage = language;
        } else {
          newUser.learnLanguage = language;
        }
        editUser.user = newUser;
      },
    );
  }
}

class UserBio extends StatelessWidget {
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
    final editUser = Provider.of<EditUser>(context, listen: false);
    return Container(
      color: Color(0xFFECEBE9),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Bio', style: bioTitleStyle),
              InkWell(
                child: Icon(
                  Icons.edit,
                  size: 40,
                  color: Colors.grey[600].withOpacity(0.5),
                ),
                onTap: () => _changeBio(context),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(editUser.user.biography,
              style: bioTextStyle, textAlign: TextAlign.justify),
        ],
      ),
    );
  }

  _changeBio(BuildContext context) {
    final editUser = Provider.of<EditUser>(context, listen: false);
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        final Usuario newUser = editUser.user;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    initialValue: editUser.user.biography,
                    decoration: InputDecoration(hintText: '...'),
                    minLines: 5,
                    maxLines: null,
                    onChanged: (bio) {
                      newUser.biography = bio;
                      editUser.user = newUser;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
