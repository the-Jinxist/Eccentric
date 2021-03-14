import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_app/datasources/network/rawg_impl.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState>{

  AchievementBloc() : super(AchievementIdleState());

  @override
  Stream<AchievementState> mapEventToState(AchievementEvent event) async* {
    if(event is LoadAchievement){
      try{
        yield AchievementLoadInProgress();
        AchievementModel model  = await getGameAchievementsService(id: event.id);
        yield AchievementLoadSuccess(model);

      }catch(e){
        yield AchievementLoadFailure(e.toString());
      }

    }
  }



}