import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/developers_bloc/z_developers_bloc.dart';
import 'package:game_app/presentation/bloc/games_via_platform_bloc/z_games_via_platform_bloc.dart';
import 'package:game_app/presentation/bloc/publishers_bloc/z_publishers_bloc.dart';

class GamesViaPlatformBloc extends Bloc<GamesViaPlatformEvent, GamesViaPlatformState>{

  GamesViaPlatformBloc() : super(GamesViaPlatformIdleState());

  @override
  Stream<GamesViaPlatformState> mapEventToState(GamesViaPlatformEvent event) async* {

    if(event is LoadGamesViaPlatforms){

      yield GamesViaPlatformLoadInProgress();

      try{

        GamesModel model  = await getYourGamesFromPlatformService(platform: event.platform);
        yield GamesViaPlatformLoadSuccess(model);

      }catch(e){

        yield GamesViaPlatformLoadFailure(e.toString());


      }



    }

  }


}