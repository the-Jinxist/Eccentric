import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class TrailersBloc extends Bloc<TrailersEvent, TrailersState>{

  TrailersBloc() : super(TrailersIdleState());

  @override
  Stream<TrailersState> mapEventToState(TrailersEvent event) async* {
    if(event is LoadTrailers){
      try{
        yield TrailersLoadInProgress();
        TrailersModel model  = await getGameTrailersService();
        yield TrailersLoadSuccess(model);

      }catch(e){
        yield TrailersLoadFailure(e.toString());
      }

    }
  }



}