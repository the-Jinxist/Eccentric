import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class DiscoverGamesPage extends StatefulWidget {
  @override
  _DiscoverGamesPageState createState() => _DiscoverGamesPageState();
}

class _DiscoverGamesPageState extends State<DiscoverGamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
        appBar: PreferredSize(child: Container(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Discover Game", style: Theme.of(context).textTheme.title,),
              Text("Find games from all categories", style: Theme.of(context).textTheme.subtitle,),
            ],
          ),
        ), preferredSize: Size.fromHeight(100)),
      body: ListView(
        padding: EdgeInsets.only( left: 15, right: 15),
        children: <Widget>[
          Container(
              height: 60,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.withOpacity(0.3)
              ),
              width: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(LineAwesomeIcons.search),
                  SizedBox(width: 10,),
                  Text("Search", style: Theme.of(context).textTheme.subtitle,)
                ],
              )
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Popular in 2020", style: Theme.of(context).textTheme.headline,),
                  Text("The most popular games this year!", style: Theme.of(context).textTheme.display2,),
                ],
              ),
              Text("View More", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 12),)
            ],
          ),
          SizedBox(height: 10),
          Container(
              height: 200,
              width: double.maxFinite,
              child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: (context, position){
                    return Container(
                        height: 100,
                        margin: EdgeInsets.only( right: 10),
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: position % 2 == 0 ? Colors.blue : Colors.orange
                        ),
                        width:10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(LineAwesomeIcons.search),
                            SizedBox(width: 10,),
                            Text("Search", style: Theme.of(context).textTheme.subtitle,)
                          ],
                        )
                    );
                  }),
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Most Awaited Games in 2020", style: Theme.of(context).textTheme.headline,),
                  Text("We're all anticipating for these games", style: Theme.of(context).textTheme.display2,),
                ],
              ),
              Text("View More", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 12),)
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            width: 10,
            child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, position){
                  return Container(
                      height: 50,
                      margin: EdgeInsets.only( right: 10),
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: position % 2 == 0 ? Colors.blue : Colors.orange
                      ),
                      width:10,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(LineAwesomeIcons.search),
                          SizedBox(width: 10,),
                          Text("Search", style: Theme.of(context).textTheme.subtitle,)
                        ],
                      )
                  );
                }),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Publishers", style: Theme.of(context).textTheme.headline,),
                  Text("Your favourite game publishers", style: Theme.of(context).textTheme.display2,),
                ],
              ),
              Text("View More", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 12),)
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: double.maxFinite,
            child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, position){
                  return Container(
                      height: 100,
                      margin: EdgeInsets.only( right: 10),
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: position % 2 == 0 ? Colors.blue : Colors.orange
                      ),
                      width:300,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(LineAwesomeIcons.search),
                          SizedBox(width: 10,),
                          Text("Search", style: Theme.of(context).textTheme.subtitle,)
                        ],
                      )
                  );
                }),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Developers", style: Theme.of(context).textTheme.headline,),
                  Text("The best, biggest game developers!", style: Theme.of(context).textTheme.display2,),
                ],
              ),
              Text("View More", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 12),)
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: double.maxFinite,
            child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, position){
                  return Container(
                      height: 100,
                      margin: EdgeInsets.only( right: 10),
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: position % 2 == 0 ? Colors.blue : Colors.orange
                      ),
                      width:300,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(LineAwesomeIcons.search),
                          SizedBox(width: 10,),
                          Text("Search", style: Theme.of(context).textTheme.subtitle,)
                        ],
                      )
                  );
                }),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Platforms", style: Theme.of(context).textTheme.headline,),
                  Text("Each and every specific device you play a game on!", style: Theme.of(context).textTheme.display2,),
                ],
              ),
              Text("View More", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 12),)
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: double.maxFinite,
            child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, position){
                  return Container(
                      height: 100,
                      margin: EdgeInsets.only( right: 10),
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: position % 2 == 0 ? Colors.blue : Colors.orange
                      ),
                      width:300,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(LineAwesomeIcons.search),
                          SizedBox(width: 10,),
                          Text("Search", style: Theme.of(context).textTheme.subtitle,)
                        ],
                      )
                  );
                }),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Parent Platforms", style: Theme.of(context).textTheme.headline,),
                  Text("Your favourite consoles by sections", style: Theme.of(context).textTheme.display2,),
                ],
              ),
              Text("View More", style: Theme.of(context).textTheme.headline.copyWith(color: Colors.orange, fontSize: 12),)
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: double.maxFinite,
            child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, position){
                  return Container(
                      height: 100,
                      margin: EdgeInsets.only( right: 10),
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: position % 2 == 0 ? Colors.blue : Colors.orange
                      ),
                      width: 200,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(LineAwesomeIcons.search),
                          SizedBox(width: 10,),
                          Text("Search", style: Theme.of(context).textTheme.subtitle,)
                        ],
                      )
                  );
                }),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("ECCENTRIC V1.0", style: Theme.of(context).textTheme.display1.copyWith(color: Colors.orange),)
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
