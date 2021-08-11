import 'package:gitkaktus/app/views/search/components/header.dart';
import 'package:gitkaktus/app/views/search/components/body.dart';
import 'package:gitkaktus/app/services/search_service.dart';
import 'package:gitkaktus/device/connection.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = new TextEditingController();
  bool dialVisible = true;
  List _result;

  Future<void> _search(String user) async {
    if (user.isNotEmpty) if (await Connection().checkConnection()) {
      List res = await SearchService().search(_searchController.text);
      setState(() {
        if (mounted) _result = res;
      });
      _searchController.clear();
    } else {
      Toast.show('C E L U L A R   S E M   C O N E X Ã O', context,
          duration: 3, gravity: Toast.TOP);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Header(height, _searchController, _search),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body: _result == null
          ? Center(
              child: Text('Informe o usuário ...'),
            )
          : RefreshIndicator(
              onRefresh: () async {
                _search(_searchController.text);
              },
              child: Body(_result)),
    );
  }
}
