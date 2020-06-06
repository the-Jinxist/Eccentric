import 'package:flutter/material.dart';
import 'package:game_app/utils/Utils.dart';

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

  bool enabledText = true;

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
            Text(widget.type == AuthType.SIGN_IN ? "Sign In": "Sign Up", style: Theme.of(context).textTheme.title,),
            Text(widget.type == AuthType.SIGN_IN ? "Glad to have you back, gamer!": "We're happy to have you join us", style: Theme.of(context).textTheme.subtitle,),
          ],
        ),
      ), preferredSize: Size.fromHeight(100)),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                          hintStyle: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey)
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "Please provide an email";
                        }else{
                          email = value.trim();
                          return null;
                        }
                      },
                      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      enabled: enabledText,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
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
                        hintStyle: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey),

                      ),
                      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.black),
                      obscureText: true,
                      validator: (value){
                        if(value.isEmpty){
                          return "Please input your password";
                        }else{
                          password = value.trim();
                          return null;
                        }
                      },
                    ),

                  ],
                ),
              ),
              SizedBox(height:40),
              GestureDetector(
                onTap: (){

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
                    child: Center(child: Text(widget.type == AuthType.SIGN_IN ? "Sign In": "Sign Up", style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),)),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  if(widget.type == AuthType.SIGN_IN){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthPage(AuthType.SIGN_UP)));
                  }else{
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthPage(AuthType.SIGN_IN)));
                  }

                },
                child: Text(widget.type == AuthType.SIGN_IN ? "Don't have an account, Sign Up!": "Already have an account, Sign In", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 15),),
              )
            ],
          ),
        )
      ),
    );
  }
}
