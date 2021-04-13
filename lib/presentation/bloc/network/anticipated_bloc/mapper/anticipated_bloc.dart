import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class AnticipatedBloc extends Bloc<AnticipatedEvent, AnticipatedState>{

  AnticipatedBloc() : super(AnticipatedIdleState());

  @override
  Stream<AnticipatedState> mapEventToState(AnticipatedEvent event) async* {
    if(event is LoadAnticipated){
      try{
        yield AnticipatedLoadInProgress();
        GamesModel model  = await getAnticipatedService();
        yield AnticipatedLoadSuccess(model);

      }catch(e){
        yield AnticipatedLoadFailure(e.toString());
      }

    }
  }



}