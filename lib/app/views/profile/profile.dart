import 'package:gitkaktus/app/views/profile/components/body.dart';
import 'package:gitkaktus/app/helpers/favorite_helper.dart';
import 'package:gitkaktus/app/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  String login;
  String avatar;
  Profile(this.login, this.avatar);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var _db = FavoriteHelper();
  ProfileModel _perfilModel;
  String _message;

  Future<void> _saveFavorite() async {
    try {
      int id = await _db.saveFavorite(_perfilModel);
      id>0 ? _message='Favoritado' : 'Não Favoritado';
    } catch (e) {
      print(e);
    }
    Toast.show(_message, context,duration: 3, gravity: Toast.TOP);
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil ' + this.widget.login,
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.amberAccent,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:Body(_perfilModel,_saveFavorite,context,this.widget.login,this.widget.avatar),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
           await _saveFavorite();
        },
        child: Icon(
          Icons.favorite_border,
          size: 30,
          color: Colors.red[600],
        ),
        backgroundColor: Colors.grey[200],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
