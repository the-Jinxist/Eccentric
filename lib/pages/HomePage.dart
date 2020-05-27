import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: Colors.orange,
                tabs: [
                  GButton(
                    icon: LineAwesomeIcons.home,
                    text: 'Home',
                    textStyle: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
                    iconActiveColor: Colors.white,
//                    iconColor: Colors.orange, ,
                  ),
                  GButton(
                    icon: LineAwesomeIcons.search,
                    text: 'Discover',
                    textStyle: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
                    iconActiveColor: Colors.white,
                  ),
                  GButton(
                    icon: LineAwesomeIcons.heart_o,
                    text: 'Saved',
                    textStyle: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
                    iconActiveColor: Colors.white,
                  ),
                  GButton(
                    icon: LineAwesomeIcons.gear,
                    text: 'Settings',
                    textStyle: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
                    iconActiveColor: Colors.white,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
