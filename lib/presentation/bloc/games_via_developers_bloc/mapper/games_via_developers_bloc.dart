import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/developers_bloc/z_developers_bloc.dart';
import 'package:game_app/presentation/bloc/games_via_developers_bloc/z_games_via_developers_bloc.dart';
import 'package:game_app/presentation/bloc/publishers_bloc/z_publishers_bloc.dart';

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