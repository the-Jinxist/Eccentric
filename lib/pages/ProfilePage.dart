import 'package:flutter/material.dart';
import 'package:game_app/pages/AuthPage.dart';
import 'package:game_app/utils/Utils.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final formKey = new GlobalKey<FormState>();
  String email;
  String password;

  bool enabledText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.only(top: 40, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Profile", style: Theme.of(context).textTheme.title,),
                Text("Join us and keep your interests and data safe across multipe deveices", style: Theme.of(context).textTheme.subtitle,),
                SizedBox(height: 150,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("You don't have an account?", style: Theme.of(context).textTheme.subtitle,),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthPage(AuthType.SIGN_UP)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        elevation: 5,
                        color: Colors.orange,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Text("Sign Up!", style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),)),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Text("You already have an account?", style: Theme.of(context).textTheme.subtitle,),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthPage(AuthType.SIGN_IN)));
                      },
                      child: Text("SIGN IN", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 20),),
                    )
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }
}
