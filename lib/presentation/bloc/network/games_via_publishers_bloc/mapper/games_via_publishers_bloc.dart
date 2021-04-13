import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/network/games_via_publishers_bloc/z_games_via_publishers_bloc.dart';

class GamesViaPublishersBloc extends Bloc<GamesViaPublishersEvent, GamesViaPublishersState>{

  GamesViaPublishersBloc() : super(GamesViaPublishersIdleState());

  @override
  Stream<GamesViaPublishersState> mapEventToState(GamesViaPublishersEvent event) async* {

    if(event is LoadGamesViaPublishers){

      yield GamesViaPublishersLoadInProgress();

      try{

        GamesModel model  = await getYourGamesFromPublishersService(publishers: event.publishers);
        yield GamesViaPublishersLoadSuccess(model);

      }catch(e){

        yield GamesViaPublishersLoadFailure(e.toString());


      }



    }

  }


}