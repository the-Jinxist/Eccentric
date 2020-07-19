import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_app/presentation/pages/LandingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
      )
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Games!',
      themeMode: ThemeMode.light,
      theme: ThemeData(
//        primarySwatch: Colors.white,
        primaryColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 24
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
            fontSize: 20,
            color: Colors.black,
          )
        ),
      tooltipTheme: TooltipThemeData(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.orange
        ),
        textStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 12,
          color: Colors.white,
          ),
        )
      ),
      home: LandingPage(),
    );
  }
}


