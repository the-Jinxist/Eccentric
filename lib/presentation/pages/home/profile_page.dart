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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: SizeConfig.screenHeightDp,
        width: SizeConfig.screenWidthDp,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LineAwesomeIcons.gamepad, color: Colors.grey,),
              YMargin(5),
              NormalText(text: "Coming soon", fontSize: 12, textColor: Colors.grey,)
            ],
          ),
        ),
      )
    );
  }

}
