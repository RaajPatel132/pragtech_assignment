import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserDataProvider with ChangeNotifier {
  List<UserModel> usersList = List.empty(growable: true);
  List<int> likedUsers = List.empty(growable: true);

  Future<void> loadAllData() async {
    likedUsers.clear();
    final pref = await SharedPreferences.getInstance();
    final liked = pref.getString('likedUsers') ?? 'null';

    if (liked != 'null') {
      liked.split(',').forEach((element) {
        likedUsers.add(int.parse(element));
      });
    }
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);
      usersList.clear();
      for (var map in list) {
        usersList.add(UserModel.fromMap(map, likedUsers));
      }
    }

    notifyListeners();
  }

  Future<void> likeUser(int id) async {
    final pref = await SharedPreferences.getInstance();
    final liked = pref.getString('likedUsers') ?? 'null';

    if (liked != 'null') {
      pref.setString('likedUsers', liked + ',${id.toString()}');
    } else {
      pref.setString('likedUsers', id.toString());
    }
    for (var element in usersList) {
      if (element.id == id) {
        element.isLiked = true;
      }
    }
    notifyListeners();
  }

  Future<void> unlikeUser(int id) async {
    final pref = await SharedPreferences.getInstance();
    final liked = pref.getString('likedUsers') ?? 'null';

    if (liked != 'null') {
      String temp = liked;
      if (liked.contains(",${id.toString()}")) {
        temp = liked.replaceAll(",${id.toString()}", "");
      } else if (liked.contains(id.toString())) {
        temp = liked.replaceAll(id.toString(), "");
      }
      pref.setString('likedUsers', temp);
    }
    for (var element in usersList) {
      if (element.id == id) {
        element.isLiked = false;
      }
    }
    notifyListeners();
  }
}
