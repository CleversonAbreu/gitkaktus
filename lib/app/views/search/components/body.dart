import 'package:gitkaktus/app/views/profile/profile.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  List result;
  Body(this.result);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (_,id){
        final item = result[id];
        return Column(children: [
          GestureDetector(
            child: Column(
              children: [
                ListTile(
                  title: Text(item.login),
                  subtitle: Text(item.id.toString()),
                  trailing: Text(
                    item.id.toString(),
                    style: TextStyle(fontSize: 11),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        item.avatar_url +
                        '.png'),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 39,
                  endIndent: 28,
                  height: 10,
                ),
              ],
            ),
            onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Profile(item.login,item.avatar_url)));
            },
          ), //),
        ]);
      },);
  }
}
