import 'package:flutter/material.dart';
import 'package:game_app/domain/models/database_model.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/presentation/pages/home/discover_games_page.dart';
import 'package:game_app/presentation/pages/home/profile_page.dart';
import 'package:game_app/presentation/pages/home/saved_games_page.dart';
import 'package:game_app/presentation/pages/home/your_games_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex =0;
  var pageController;

  @override
  void initState() {

    storeSavedGames();
    pageController = PageController(initialPage: 0, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (position){
          setState(() {
            _selectedIndex = position;
          });
        },
        children: <Widget>[
          YourGamesPage(), DiscoverGamesPage(), SavedGamesPage(), ProfilePage()
        ],
      ),
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
                    textStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                    iconActiveColor: Colors.white,
//                    iconColor: Colors.orange, ,
                  ),
                  GButton(
                    icon: LineAwesomeIcons.search,
                    text: 'Discover',
                    textStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                    iconActiveColor: Colors.white,
                  ),
                  GButton(
                    icon: LineAwesomeIcons.heart_o,
                    text: 'Saved',
                    textStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                    iconActiveColor: Colors.white,
                  ),
                  GButton(
                    icon: LineAwesomeIcons.user,
                    text: 'Profile',
                    textStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                    iconActiveColor: Colors.white,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                    pageController.animateToPage(_selectedIndex, duration: Duration(microseconds: 10), curve: ElasticInCurve(0.8));
                  });
                }),
          ),
        ),
      ),
    );
  }

  Future storeSavedGames() async{
    print("Finding user");
    var user = await AuthRepo.getCurrentUser();
    if(user != null){
      print("User dey");
      var map = await DatabaseHelper().getGameList();
      DatabaseRepo.storeSavedGames(userID: user.uid, savedGames: map);
    }else{
      print("User no dey");
    }

  }
}
