import 'package:bloc_test/bloc_test.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class MockAchievementBloc extends MockBloc<AchievementEvent, AchievementState> implements AchievementBloc{}