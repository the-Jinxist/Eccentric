import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/network/games_via_developers_bloc/z_games_via_developers_bloc.dart';

class GamesViaDevelopersBloc extends Bloc<GamesViaDevelopersEvent, GamesViaDevelopersState>{

  GamesViaDevelopersBloc() : super(GamesViaDeveloperIdleState());

  @override
  Stream<GamesViaDevelopersState> mapEventToState(GamesViaDevelopersEvent event) async* {

    if(event is LoadGamesViaDevelopers){

      yield GamesViaDevelopersLoadInProgress();

      try{

        GamesModel model  = await getYourGamesFromDevelopersService(developers: event.developers);
        yield GamesViaDevelopersLoadSuccess(model);

      }catch(e){

        yield GamesViaDevelopersLoadFailure(e.toString());


      }



    }

  }


}