import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class PlatformBloc extends Bloc<PlatformEvent, PlatformState>{

  PlatformBloc() : super(PlatformIdleState());

  @override
  Stream<PlatformState> mapEventToState(PlatformEvent event) async* {
    if(event is LoadPlatform){
      try{
        yield PlatformLoadInProgress();
        PlatformModel model  = await getPlatformsService();
        yield PlatformLoadSuccess(model);

      }catch(e){
        yield PlatformLoadFailure(e.toString());
      }

    }
  }



}