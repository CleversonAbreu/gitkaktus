import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  List _favorites;
  final Function(int value) onDismissed;

  Body(this._favorites, this.onDismissed);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          return Column(children: [
            Dismissible(
                key: Key(_favorites[index]['id'].toString()),
                onDismissed: (direction) {
                  if (_favorites.length > 0) {
                    this.onDismissed(_favorites[index]['id']);
                  }
                },
                child: Column(
                  children: [
                    ListTile(
                      title: Text(_favorites[index]['name'] ??
                          "" + "\n" + _favorites[index]['email'] ??
                          ""),
                      subtitle: Text(_favorites[index]['bio'] ??
                          "" + "\n" + _favorites[index]['location'] ??
                          ""),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(_favorites[index]['avatar_url'] ?? ""),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 39,
                      endIndent: 28,
                      height: 10,
                    ),
                  ],
                )),
          ]);
        });
  }
}
