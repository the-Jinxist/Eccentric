import 'package:flutter/material.dart';
import 'pages/GenresPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Games!',
      themeMode: ThemeMode.light,
      theme: ThemeData(
//        primarySwatch: Colors.white,
        primaryColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        accentColor: Colors.orange,
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: "Lato_Bold",
            fontSize: 35,
            color: Colors.black,
          ),
          subtitle: TextStyle(
            fontFamily: "Poppins",
            fontSize: 17,
            color: Colors.black,
          ),
          display1: TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            color: Colors.black,
          ),
          display2: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            color: Colors.black,
          ),
          headline: TextStyle(
            fontFamily: "Poppins_Extrabold",
            fontSize: 12,
            color: Colors.black,
          )
        ),
      ),
      home: GenresPage(),
    );
  }
}


