import 'package:flutter/material.dart';
import 'package:nasa_app/api_service/ApiService.dart';
import 'package:nasa_app/detailScreen.dart';
import 'package:nasa_app/detailWidget.dart';
import 'package:nasa_app/model/apod.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        body: FutureBuilder<List<Apod>>(
          future: apiService.get10Entries(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => detailWidget(
                                        snapshot.data![index].copyright,
                                        snapshot.data![index].date,
                                        snapshot.data![index].explanation,
                                        snapshot.data![index].title,
                                        snapshot.data![index].url)));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[Colors.cyan, Colors.red],
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.62,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].title,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(snapshot.data![index].explanation,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                  height:
                                      MediaQuery.of(context).size.width * 0.21,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data![index].url),
                                          fit: BoxFit.cover)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
