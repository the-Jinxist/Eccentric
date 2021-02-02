import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/datasources/api/rawg_api.dart' as api;
import 'package:game_app/domain/models/publishers_model.dart';
import 'package:game_app/presentation/pages/category/publishers_page.dart';
import 'package:game_app/presentation/view/publisher_view.dart';

class AllPublishersPage extends StatefulWidget {
  @override
  _AllPublishersPageState createState() => _AllPublishersPageState();
}

class _AllPublishersPageState extends State<AllPublishersPage> {

  Future publishersFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    publishersFuture = _getPublishers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Publishers", style: Theme.of(context).textTheme.title, ),
            Text("The best of tha best!", style: Theme.of(context).textTheme.subtitle,),
          ],
        ),
      ), preferredSize: Size.fromHeight(100)),
      body: FutureBuilder(
        future: publishersFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if(snapshot.hasData){
            var publisherModel = snapshot.data as PublishersModel;

            return ListView.builder(
                padding: EdgeInsets.only(left: 10, right: 5),
                itemCount: publisherModel.results.length,
                itemBuilder: (context, position){
                  var model = publisherModel.results[position];
                  return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PublishersPage(model)));
                      },
                      child: Container(margin: EdgeInsets.only(bottom: 5, top: 5),child: PublisherView(model, "publishers"))
                  );
                }
            );
          }else if(snapshot.hasError){
            return Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry an error occured",style: Theme.of(context).
                    textTheme.display1, textAlign: TextAlign.center,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          publishersFuture = _getPublishers();
                        });
                      },
                      child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),),
                    ),
                  ],
                ),
              ),
            );
          } else{
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<PublishersModel>_getPublishers() async{
    var response = await api.getPublishers();
    if(response.statusCode == 200){
      var model = PublishersModel.fromJson(json.decode(response.body));
      return model;
    }else{
      print("All Publishers Page Error: ${response.statusCode}");
      return null;
    }

  }

}
