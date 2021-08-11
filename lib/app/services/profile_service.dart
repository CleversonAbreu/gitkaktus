import 'package:gitkaktus/app/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ProfileService {

  Future<ProfileModel> getProfile(String user) async {
    var _url = "https://api.github.com/users/" + user;

    var response = await http.get(_url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return ProfileModel.fromMap(jsonResponse);
    }
  }
}
