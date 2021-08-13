import 'package:flutter/material.dart';
import 'package:gitkaktus/app/models/profile_model.dart';
import 'package:gitkaktus/app/services/profile_service.dart';
import 'package:gitkaktus/app/views/profile/components/profile_bio.dart';
import 'package:gitkaktus/app/views/profile/components/profile_image.dart';

class Body extends StatefulWidget {
  ProfileModel perfilModel;
  final BuildContext context;
  final VoidCallback saveFavorite;
  final String login;
  final String avatar;

  Body(this.perfilModel,this.saveFavorite,this.context,this.login,this.avatar);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 6.1,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(this.widget.context).size;

    return Center(
      child: FutureBuilder<dynamic>(
        future: ProfileService().getProfile(this.widget.login),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            this.widget.perfilModel = snapshot.data;
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
    );
  }
}
