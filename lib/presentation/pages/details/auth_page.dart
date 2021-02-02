import 'package:flutter/material.dart';
import 'package:game_app/datasources/repo/auth_repo.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/domain/utils/utils.dart';
import 'package:game_app/presentation/pages/home/home_page.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';

class AuthPage extends StatefulWidget {

  final AuthType type;

  AuthPage(this.type);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final formKey = new GlobalKey<FormState>();
  String email;
  String password;
  LoadingStates states = LoadingStates.IDLE;

  bool enabledText = true;

  final SizeConfig _config = SizeConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TitleText(text: widget.type == AuthType.SIGN_IN ? "Sign In": "Sign Up", ),
            NormalText(text: widget.type == AuthType.SIGN_IN ? "Glad to have you back, gamer!": "We're happy to have you join us", ),
          ],
        ),
      ), preferredSize: Size.fromHeight(100)),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeightDp,
          color: Colors.white,
          padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 30),
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      enabled: enabledText,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      decoration: InputDecoration(
                          errorStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 1.0
                              )
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0
                              )
                          ),
                          hintText: "youremail@email.com",
                          hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey)
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "Please provide an email";
                        }else{
                          setState(() {
                            email = value.trim();
                          });

                          return null;
                        }
                      },
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
                    ),
                    YMargin(20,),
                    TextFormField(
                      enabled: enabledText,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        errorStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange,
                                width: 1.0
                            )
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0
                            )
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0
                            )
                        ),
                        hintText: "Password",
                        hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),

                      ),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
                      obscureText: true,
                      validator: (value){
                        if(value.isEmpty){
                          return "Please input your password";
                        }else{
                          setState(() {
                            password = value.trim();
                          });

                          return null;
                        }
                      },
                    ),

                  ],
                ),
              ),
              states == LoadingStates.IDLE ? SizedBox(height:40)
                  : states == LoadingStates.LOADING ? SizedBox(
                    height:40,
                    width: MediaQuery.of(context).size.width,
                child: Center(
                child: Column(
                  children: <Widget>[
                    YMargin(20),
                    CircularProgressIndicator(),
                    YMargin(20),
                  ],
                ),
              ),): states == LoadingStates.ERROR ? SizedBox(
                  height:40,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: NormalText(text: "Sorry an error occurred. Check your internet and try again!", textColor: Colors.red, fontWeight: FontWeight.bold,),
                  )): Container(),
              GestureDetector(
                onTap: (){
                  if(widget.type == AuthType.SIGN_IN){
                    //Sign In

                    var validated = formKey.currentState.validate();
                    if(validated){
                      setState(() {
                        states = LoadingStates.LOADING;
                      });
                      AuthRepo.signInWithEmailAndPassword(email: email, password: password).then((value){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                      }, onError: (){
                        setState(() {
                          states  = LoadingStates.ERROR;
                        });
                      });

                    }

                  }else{
                    //Sign Up

                    var validated = formKey.currentState.validate();
                    if(validated){
                      setState(() {
                        states = LoadingStates.LOADING;
                      });
                      AuthRepo.signUpWithEmailAndPassword(email: email, password: password).then((value){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                      }, onError: (object){
                        setState(() {
                          states  = LoadingStates.ERROR;
                        });
                      });

                    }

                  }
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
                    child: Center(child: NormalText(text: widget.type == AuthType.SIGN_IN ? "Sign In": "Sign Up", textColor: Colors.white,)),
                  ),
                ),
              ),
              YMargin(20,),
              GestureDetector(
                onTap: (){
                  if(widget.type == AuthType.SIGN_IN){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthPage(AuthType.SIGN_UP)));
                  }else{
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthPage(AuthType.SIGN_IN)));
                  }

                },
                child: TitleText(text: widget.type == AuthType.SIGN_IN ? "Don't have an account, Sign Up!": "Already have an account, Sign In", textColor: Colors.orange, fontSize: 15,),
              )
            ],
          ),
        )
      ),
    );
  }
}
