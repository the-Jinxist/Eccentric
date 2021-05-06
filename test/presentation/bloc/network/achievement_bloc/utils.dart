import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:mockito/mockito.dart';

const idleState = TypeMatcher<AchievementIdleState>();
const loadingState =  TypeMatcher<AchievementLoadInProgress>();
const successState = TypeMatcher<AchievementLoadSuccess>();
const failureState = TypeMatcher<AchievementLoadFailure>();

class MockDatabase extends Mock implements DatabaseHelper{

}

class MockAchievementBloc extends MockBloc<AchievementEvent, AchievementState> implements AchievementBloc{}