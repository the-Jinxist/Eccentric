import 'package:flutter/material.dart';
import 'package:game_app/pages/GenresPage.dart';
import 'package:game_app/pages/HomePage.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:game_app/repo/PrefsRepo.dart' as repo;

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {

  AnimationController motionController;
  Animation motionAnimation;
  double size = 30;

  @override
  void initState() {
    // TODO: implement initState

    motionController = AnimationController(vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 0.5
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addListener((){
      setState(() {
        size = motionController.value * 60;
      });
    });

    super.initState();

    repo.getGenreString().then((string){
      if(string != null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GenresPage()));
      }
    });
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    motionController.addStatusListener((status){
      setState(() {
        if(status == AnimationStatus.completed){
          print("Completed");
          motionController.reverse();
        }else if(status == AnimationStatus.dismissed){
          print("Completed");
          motionController.forward();
        }
      });
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.maxFinite,
        width: double.maxFinite,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                LineAwesomeIcons.gamepad,
                size: size,
                color: Colors.orange,
              ),
              Text("G A M E", style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.orange),)
            ],
          ),
        ),
      ),
//      body: Container(
//        color: Colors.white,
//        height: double.maxFinite,
//        width: double.maxFinite,
//        child: Center(
//          child: Column(
//            children: <Widget>[
//              Icon(
//                LineAwesomeIcons.gamepad,
//                size: 30,
//                color: Colors.orange,
//              ),
//              Text("G A M E", style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.orange),)
//            ],
//          ),
//        ),
//      ),
    );
  }
}
