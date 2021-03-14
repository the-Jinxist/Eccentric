import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState>{

  DetailsBloc() : super(DetailsIdleState());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if(event is LoadDetails){
      try{
        yield DetailsLoadInProgress();
        GameDetailModel model  = await getGameDetailsService(id: event.id);
        yield DetailsLoadSuccess(model);

      }catch(e){
        yield DetailsLoadFailure(e.toString());
      }

    }
  }



}