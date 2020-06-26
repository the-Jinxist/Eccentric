import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_app/pages/AuthPage.dart';
import 'package:game_app/repo/AuthRepo.dart';
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

  AuthRepo authRepo;
  Future getCurrentUser;

  @override
  void initState() {
    authRepo = AuthRepo();
    getCurrentUser = authRepo.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: FutureBuilder(
            future: getCurrentUser,
            builder: (context, snapshot){
              if(snapshot.connectionState != ConnectionState.done){
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else if(snapshot.hasData){
                var user = (snapshot.data as FirebaseUser);
                return user != null ? userPage(user) : noUserPage();
              }else if(snapshot.hasError){
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Sorry an error occured",style: Theme.of(context).
                        textTheme.display1, textAlign: TextAlign.center,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              getCurrentUser = authRepo.getCurrentUser();
                            });
                          },
                          child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),),
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

            }
          )
      ),
    );
  }

  Widget noUserPage(){
    return Container(
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
    );
  }

  Widget userPage(FirebaseUser user){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.only(top: 40, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(LineAwesomeIcons.user, size: 30,),
          Text("${user.email}", style: Theme.of(context).textTheme.display1,),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Text("Hey there!", style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),),
              SizedBox(width: 10,),
              Text("We ddn't save a username so, what's up there! :)", style: Theme.of(context).textTheme.display1.copyWith(fontSize: 10),),

            ],
          ),
          Text("${user.displayName} hmm? Anyways, we're constantly updating your saved games to our servers. To make sure you can"
              "access these games on various devices.",
            style: Theme.of(context).textTheme.display1,),


        ],
      ),
    );
  }

}
