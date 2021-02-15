import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class ScreenshotBloc extends Bloc<ScreenshotEvent, ScreenshotState>{

  ScreenshotBloc() : super(ScreenshotIdleState());

  @override
  Stream<ScreenshotState> mapEventToState(ScreenshotEvent event) async* {
    if(event is LoadScreenshot){
      try{
        yield ScreenshotLoadInProgress();
        ScreenshotsModel model  = await getGameScreenshotsService(slug: event.slug);
        yield ScreenshotLoadSuccess(model);

      }catch(e){
        yield ScreenshotLoadFailure(e.toString());
      }

    }
  }



}