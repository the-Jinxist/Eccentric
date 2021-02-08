import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/domain/models/genre_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/home/home_page.dart';
import 'package:game_app/presentation/widgets/filter_chip_widget.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';

class GenresPage extends StatefulWidget {
  @override
  _GenresPageState createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {

  List<String> genreList = [];

  final SizeConfig _config = SizeConfig();

  @override
  void initState() {

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
              TitleText(text: "Genres", ),
              NormalText(text: "Select genres that excite you!",),
              YMargin(10),
              BlocBuilder<GenresBloc, GenresState>(
                builder: (context, state){
                  if(state is GenresLoadInProgress){
                    return Container(
                      height: _config.sh(300),
                      width: SizeConfig.screenWidthDp,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }else if(state is GenresLoadSuccess){
                    return Wrap(
                        runSpacing: 3,
                        spacing: 10,
                        children: List<Widget>.generate(
                          state.genres.results.length,
                          (position){
                            return FilterChipWidget(
                              '${state.genres.results[position].name}',
                              genreList,
                              '${state.genres.results[position].slug}',
                                state.alreadyAddedGenres
                            );
                        }).toList()
                    );
                  }else if(state is GenresLoadFailure){
                    return Container(
                      height: _config.sh(200),
                      width: SizeConfig.screenWidthDp,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            NormalText(text: "An error occurred. Please check your internet connection"),
                            YMargin(10),
                            GestureDetector(
                              onTap: (){
                                BlocProvider.of<GenresBloc>(context).add(LoadGenres());
                              },
                              child: NormalText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  else{
                    return Container(
                      height: _config.sh(300),
                      width: SizeConfig.screenWidthDp,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }
              ),
              YMargin(30),
              GestureDetector(
                onTap: (){
                  print("From Genre Page: The final genre list ${genreList.toString().substring(1, genreList.toString().length - 1)}");

                  BlocProvider.of<GenresBloc>(context).add(
                    SaveGenres(genreList.toString().substring(1, genreList.toString().length - 1))
                  );

                  BlocProvider.of<GenresBloc>(context).listen((GenresState state) {
                    if(state is SaveGenresSuccess){

                    }else{

                    }
                  });
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
                    child: Center(child: NormalText(text: "Proceed", textColor: Colors.white, )),
                  ),
                ),
              ),
              YMargin(30),
            ],
          ),
        ),
      ),
    );
  }

}



