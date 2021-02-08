import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class YourGamesBloc extends Bloc<YourGamesEvent, YourGamesState>{

  YourGamesBloc() : super(YourGamesIdleState());

  @override
  Stream<YourGamesState> mapEventToState(YourGamesEvent event) async* {
    if(event is LoadYourGames){
      try{
        yield YourGamesLoadInProgress();
        GamesModel model  = await getYourGamesService();
        yield YourGamesLoadSuccess(model);

      }catch(e){
        yield YourGamesLoadFailure(e.toString());
      }

    }
  }



}