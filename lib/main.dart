import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nasa_app/bottomNav.dart';
import 'package:nasa_app/detailScreen.dart';
import 'package:nasa_app/detailWidget.dart';
import 'package:nasa_app/listScreen.dart';

import 'api_service/ApiService.dart';
import 'detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService();
  var _user = TextEditingController();
  var _pass = TextEditingController();
  var loginSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.cyan, Colors.red],
                ),
              ),
              child: Image.asset("assets/images/planeta.png"),
            ),
            Center(
              child: Card(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 200),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Usuari"),
                        controller: _user,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Contrasenya"),
                        obscureText: true,
                        controller: _pass,
                      ),
                      const SizedBox(height: 20),
                      Builder(
                        builder: (context) => ElevatedButton(
                          onPressed: () async {
                            loginSuccess =
                                await apiService.login(_user.text, _pass.text);
                            if (loginSuccess) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BottomNav()));
                            } else {}
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
