import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{

  SearchBloc() : super(SearchIdleState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if(event is LoadSearch){
      try{
        yield SearchLoadInProgress();
        GamesModel model  = await getYourGamesFromSearchService(query: event.searchQuery);
        yield SearchLoadSuccess(model);

      }catch(e){
        yield SearchLoadFailure(e.toString());
      }

    }
  }



}