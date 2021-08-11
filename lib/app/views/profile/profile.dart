import 'package:gitkaktus/app/views/profile/components/profile_image.dart';
import 'package:gitkaktus/app/views/profile/components/profile_bio.dart';
import 'package:gitkaktus/app/services/profile_service.dart';
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
  ProfileModel perfilModel;
  String message;

  Future<void> _saveFavorite() async {
    try {
      int id = await _db.saveFavorite(perfilModel);
      id>0 ? message='Favoritado' : 'Não Favoritado';
    } catch (e) {
      print(e);
    }
    Toast.show(message, context,duration: 3, gravity: Toast.TOP);
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 6.1,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
      ),
    );
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
      body: Center(
        child: FutureBuilder<dynamic>(
          future: ProfileService().getProfile(this.widget.login),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              perfilModel = snapshot.data;
              return ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 1),
                    child: Stack(
                      children: <Widget>[
                        _buildCoverImage(screenSize),
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: screenSize.height / 10.4),
                                ProfileImage(this.widget.avatar ?? ""),
                                ProfileBio(
                                    this.widget.login,
                                    snapshot.data.name ?? "Não informado",
                                    snapshot.data.email ?? "Não informado",
                                    snapshot.data.bio ?? "Não informado",
                                    snapshot.data.location ?? "Não informado"),
                                //  _buildButtons(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 0.5,
                  color: Colors.white,
                ),
                itemCount: 1, // snapshot.data.length //snapshot.data.length
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
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
