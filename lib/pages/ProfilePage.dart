import 'package:flutter/material.dart';
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
                SizedBox(height: 20,),
                Icon(LineAwesomeIcons.user, size: 100, color: Colors.orange,),
                SizedBox(height: 20,),
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
                      child: Center(child: Text("Sign Up!", style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),)),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
