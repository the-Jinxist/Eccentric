import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

import 'utils.dart';

void main(){

  AchievementBloc bloc;

  setUp((){
    bloc = MockAchievementBloc();
  });

  group("Making sure the bloc emits the states the right way", (){

    blocTest(
      'emits [] when nothing is added',
      build: () async => AchievementBloc(),
      expect: [],
    );

    blocTest(
      'emits loadInProgress when loadAchievementState is added',
      build: () async => AchievementBloc(),
      act: (bloc) => bloc.add(LoadAchievement(1111)),
      wait: const Duration(milliseconds: 300),
      expect: <AchievementState>[AchievementLoadInProgress(), AchievementLoadFailure("Exception: Exception: 401, {\"error\": \"The key parameter is not provided\"}")]
    );

  });

  tearDown((){
    bloc.close();
  });

}