import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/network/games_via_platform_bloc/z_games_via_platform_bloc.dart';

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