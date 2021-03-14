import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/domain/utils/utils.dart';
import 'package:game_app/presentation/pages/details/auth_page.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';
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
  Future getCurrentUser;

  final SizeConfig _config = SizeConfig();

  @override
  void initState() {
    getCurrentUser = AuthRepo.getCurrentUser();
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
              print("Profile data: ${snapshot.data}");
              if(snapshot.connectionState != ConnectionState.done){
                return Container(
                  height: SizeConfig.screenHeightDp,
                  width: SizeConfig.screenWidthDp,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else if(snapshot.hasData){
                print("Profile has data: ${snapshot.data}");
                var user = (snapshot.data as FirebaseUser);
                return user != null ? userPage(user) : noUserPage();
              }else if(snapshot.hasError){
                return Container(
                  height: SizeConfig.screenHeightDp,
                  width: SizeConfig.screenWidthDp,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        NormalText(text: "Sorry an error occured", textAlign: TextAlign.center,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              getCurrentUser = AuthRepo.getCurrentUser();
                            });
                          },
                          child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                if(snapshot.data == null){
                  return noUserPage();
                }
                return Container(
                  height: SizeConfig.screenHeightDp,
                  width: SizeConfig.screenWidthDp,
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
      height: SizeConfig.screenHeightDp,
      width: SizeConfig.screenWidthDp,
      color: Colors.white,
      padding: EdgeInsets.only(top: 40, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TitleText(text: "Profile", ),
          NormalText(text: "Join us and keep your interests and data safe across multipe deveices",),
          SizedBox(height: 150,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NormalText(text: "You don't have an account?",),
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
                    height: _config.sh(50),
                    width: SizeConfig.screenWidthDp,
                    child: Center(child: TitleText(text: "Sign Up!", textColor: Colors.white,)),
                  ),
                ),
              ),
              YMargin(50,),
              NormalText(text: "You already have an account?",),
              YMargin(10,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthPage(AuthType.SIGN_IN)));
                },
                child: NormalText(text: "SIGN IN", textColor: Colors.orange, fontSize: 20,),
              )
            ],
          ),

        ],
      ),
    );
  }

  Widget userPage(FirebaseUser user){
    return Container(
      height: SizeConfig.screenHeightDp - 50,
      width: SizeConfig.screenWidthDp,
      color: Colors.white,
      padding: EdgeInsets.only(top: 40, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(LineAwesomeIcons.user, size: 50,),
          NormalText(text: "${user.email}",),
          YMargin(20,),
          NormalText(text: "Hey there!", fontSize: 20,),
          NormalText(text: "We ddn't save a username so, what's up there! :)", fontSize: 12,),
          YMargin(30,),
          NormalText(text: "${user.email} hmm? Anyways, we're constantly updating your saved games to our servers. To make sure you can"
              "access these games on various devices.",),
          YMargin(50,),
          GestureDetector(
            onTap: (){
              AuthRepo.signOut();
            },
            child: TitleText(text: "SIGN OUT", textColor: Colors.orange, fontSize: 20,),
          )

        ],
      ),
    );
  }

  Future signOut() async{
    await AuthRepo.signOut();
    setState(() {
      getCurrentUser = AuthRepo.getCurrentUser();
    });
  }

}
