import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service/ApiService.dart';

class detailWidget extends StatefulWidget {
  final String copyright;
  final String date;
  final String explanation;
  final String title;
  final String url;

  detailWidget(
      this.copyright, this.date, this.explanation, this.title, this.url);

  @override
  State<detailWidget> createState() => _detailWidgetState();
}

class _detailWidgetState extends State<detailWidget> {
  final ApiService apiService = ApiService();
  bool alreadyFav = false;

  @override
  Widget build(BuildContext context) {
    File? _displayImage;
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      title: widget.title,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.url), fit: BoxFit.cover)),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.40),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        widget.title,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(alreadyFav
                                ? Icons.favorite
                                : Icons.favorite_border),
                            tooltip: 'Favourite',
                            onPressed: () async {
                              apiService.postFav(
                                  await getId(),
                                  widget.date,
                                  widget.explanation,
                                  widget.title,
                                  widget.url,
                                  widget.copyright);
                              setState(() {
                                alreadyFav = !alreadyFav;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            tooltip: 'Share image',
                            onPressed: () async {
                              final uri = Uri.parse(widget.url);
                              final response = await http.get(uri);
                              final bytes = response.bodyBytes;

                              Directory temp = await getTemporaryDirectory();
                              final path = '${temp.path}/image.jpg';
                              File(path).writeAsBytesSync(bytes);

                              await Share.shareFiles([path],
                                  text: widget.title + "\n" + widget.date);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(widget.copyright,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        widget.date,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 35),
                      Text(widget.explanation,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 17,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

getId() async {
  final prefs = await SharedPreferences.getInstance();
  final String? id = prefs.getString('id');
  return id;
}
