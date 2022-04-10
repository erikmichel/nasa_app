import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_app/model/apod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<Apod> getData() async {
    var url = 'api.nasa.gov';
    var urlExtension = '/planetary/apod';
    final Map<String, String> queryParameters = <String, String>{
      'api_key': '6u8YizBXHawwVvOgDaJXNXJoUoxQ2xTZzxXWC11Y',
    };
    final api = Uri.https(url, urlExtension, queryParameters);
    print(api);

    final response = await http.get(api);

    if (response.statusCode == 200) {
      return Apod.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Apod>> get10Entries() async {
    var url = 'api.nasa.gov';
    var urlExtension = '/planetary/apod';
    final Map<String, String> queryParameters = <String, String>{
      'api_key': '6u8YizBXHawwVvOgDaJXNXJoUoxQ2xTZzxXWC11Y',
      'count': "10",
    };
    final api = Uri.https(url, urlExtension, queryParameters);
    print(api);

    final response = await http.get(api);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Apod>((json) => Apod.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Apod>> getFavEntries() async {
    var url = 'http://sundarabcn.com/flutter/readData.php?idUser=9';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Apod>((json) => Apod.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<bool> login(String user, String pass) async {
    var url = "http://www.sundarabcn.com/flutter/login.php";
    bool isLogin = false;
    final prefs = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(url),
        headers: {'Accept': 'application/json'},
        body: {'username': user, 'password': pass});

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        showToast(jsondata["message"]);
        isLogin = false;
      } else if (jsondata["success"]) {
        showToast("Login correcte");
        isLogin = true;
        await prefs.setString('id', jsondata["id"]);
      }
    } else {
      showToast("Error de connexió");
      isLogin = false;
    }
    return isLogin;
  }

  postFav(String idUser, String date, String explanation, String title,
      String url, String copyright) async {
    var url = "http://www.sundarabcn.com/flutter/addData.php";

    var response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json'
    }, body: {
      'idUser': idUser,
      'date': date,
      'explanation': explanation,
      'title': title,
      'url': url,
      'copyright': copyright
    });

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"] == 1) {
        showToast("Error al afegir");
      } else if (jsondata["success"] == 1) {
        showToast("Afegit correctament");
      }
    } else {
      showToast("Error de connexió");
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
