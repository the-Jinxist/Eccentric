import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/network/popular_bloc/z_popular_bloc.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState>{

  PopularBloc() : super(PopularIdleState());

  @override
  Stream<PopularState> mapEventToState(PopularEvent event) async* {
    if(event is LoadPopular){

      yield PopularLoadInProgress();

      try{

        GamesModel model =  await getPopularService();
        yield PopularLoadSuccess(model);

      }catch(e){

        yield PopularLoadFailure(e.toString());
      }

    }
  }



}