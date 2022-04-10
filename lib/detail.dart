import 'package:flutter/material.dart';

void main() => runApp(const Detail());

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var title = 'App per fer proves';
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      title: title,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: size.height * 0.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://apod.nasa.gov/apod/image/2202/albireoSpectrum1024.jpg"),
                        fit: BoxFit.cover)),
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
                    children: const [
                      SizedBox(height: 3),
                      Text(
                        "Chamaeleon | Molecular Cloud",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 35),
                      Text("Robert Eder",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        "2022-02-24",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 35),
                      Text(
                          "DataBeta Cygni is a single bright star to the naked eye. About 420 light-years away it marks the foot of the Northern Cross, famous asterism in the constellation Cygnus. But a view through the eyepiece of a small telescope will transform it into a beautiful double star, a treasure of the night sky in blue and gold. Beta Cygni is also known as Albireo, designated Albireo AB to indicate its two bright component stars. Their visually striking color difference is illustrated in this telescopic snapshot, along with their associated visible spectrum of starlight shown in insets to the right. Albireo A, top inset, shows the spectrum of a K-type giant star, cooler than the Sun and emitting most of its energy at yellow and red wavelengths. Below, Albireo B has the spectrum of a main sequence star much hotter than the Sun, emitting more energy in blue and violet. Albireo A is known to be a binary star, two stars together orbiting a common center of mass, though the two stars are too close together to be seen separately with a small telescope. Well-separated Albireo A and B most likely represent an optical double star and not a physical binary system because the two components have clearly different measured motions through space.",
                          textAlign: TextAlign.start,
                          style: TextStyle(
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
