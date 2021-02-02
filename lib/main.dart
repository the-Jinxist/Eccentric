import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/pages/landing_page.dart';

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
      title: 'Eccentric!',
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
          headline1: TextStyle(
            fontFamily: "Lato_Bold",
            fontSize: 35,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontFamily: "Poppins",
            fontSize: 17,
            color: Colors.black,
          ),

          bodyText1: TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            color: Colors.black,
          ),
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
      home: Builder(
        builder: (BuildContext context){

          Size size = MediaQuery.of(context).size;
          SizeConfig.init(context, width: size.width, height: size.height, allowFontScaling: true);

          return LandingPage();
      }),
    );
  }
}


