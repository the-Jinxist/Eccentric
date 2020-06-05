import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/api/RawgApi.dart' as api;
import 'package:game_app/pages/HomePage.dart';
import 'package:game_app/repo/PrefsRepo.dart' as repo;
import 'package:game_app/models/GenreModel.dart';

class GenresPage extends StatefulWidget {
  @override
  _GenresPageState createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {

  List<String> genreList = [];
  List<String> alreadySelectedGenres;

  Future future;

  @override
  void initState() {
    future = getGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Genres", style: Theme.of(context).textTheme.title,),
              Text("Select genres that excite you!", style: Theme.of(context).textTheme.subtitle,),
              SizedBox(height: 10),
              loadGenres(),
              SizedBox(height: 30),
              GestureDetector(
                onTap: (){
                  print("From Genre Page: The final genre list ${genreList.toString().substring(1, genreList.toString().length - 1)}");
                  saveAndProceed(genreList.toString().substring(1, genreList.toString().length - 1));
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
                    child: Center(child: Text("Proceed", style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),)),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadGenres() {
    return FutureBuilder(
      future: getGenres(),
      builder: (context, snapshot){
        if(snapshot.connectionState != ConnectionState.done){
          return Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }else if(snapshot.hasData){
          var results = (snapshot.data as GenreModel).results;
          return Wrap(
            runSpacing: 3,
            spacing: 10,
              children: List<Widget>.generate(results.length, (position){
                return FilterChipWidget('${results[position].name}', genreList, '${results[position].slug}', alreadySelectedGenres);
              }).toList()
          );

        }else if(snapshot.hasError){
          print("Genres Loading Error: ${snapshot.error.toString()}");
          return Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("An error occurred. Please check your internet connection"),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        future = getGenres();
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
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<GenreModel> getGenres() async {
    var response  = await api.getGenres();
    await repo.getGenreString().then((string){
      if(string != null) {
        alreadySelectedGenres = string.split(", ");
        genreList = alreadySelectedGenres;
        print("Already selected genres: ${alreadySelectedGenres.toString()}");
        print("Initial genres: ${genreList.toString()}");
      }else{
        alreadySelectedGenres = [];
        print("Already selected genres: ${alreadySelectedGenres.toString()}");
        print("Initial genres: ${genreList.toString()}");
      }
    });
    if (response.statusCode == 200){
      var responseBody = json.decode(response.body);
      print("Genre Model: $responseBody");
      return GenreModel.fromJson(responseBody);
    }else{
      print("Genre Error: ${response.statusCode}");
      return null;
    }
  }

  Future saveAndProceed(String substring) async {
    await repo.setGenreString(substring);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}

class FilterChipWidget extends StatefulWidget {

  final String label;
  final List<String> genreList;
  final String slug;
  final List<String> alreadySelectedGenres;

  FilterChipWidget(this.label, this.genreList, this.slug, this.alreadySelectedGenres);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {

  var _isSelected;

  @override
  void initState() {
   _isSelected = widget.alreadySelectedGenres.contains(widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      onSelected: (bool){
        setState(() {
          _isSelected = bool;
          if(bool){
            setState(() {
              widget.genreList.add(widget.slug);
              print("From Genre Page: ${widget.genreList.toString()}");
            });
          }else{
            setState(() {
              widget.genreList.remove(widget.slug);
              print("From Genre Page: ${widget.genreList.toString()}");
            });
          }
        });
      },
      elevation: 5,
      labelStyle: TextStyle(color: _isSelected ? Colors.white : Colors.black, fontSize: 15, fontFamily: "Poppins" ),
      selectedColor: Colors.orange,
      selected: _isSelected,
      selectedShadowColor: Colors.orange,
      backgroundColor: Colors.white,
//                    labelPadding: EdgeInsets.all(10),
      checkmarkColor: Colors.white,

    );
  }
}

