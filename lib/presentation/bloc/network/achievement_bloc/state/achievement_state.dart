import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class AchievementState extends Equatable {
  const AchievementState();

  @override
  List<Object> get props => [];
}

class AchievementIdleState extends AchievementState {}

class AchievementLoadInProgress extends AchievementState {}

class AchievementLoadSuccess extends AchievementState {
  final AchievementModel achievement;

  const AchievementLoadSuccess([this.achievement]);

  @override
  List<Object> get props => [achievement];

  @override
  String toString() => 'AchievementLoadSuccess { achievement $achievement }';
}

class AchievementLoadFailure extends AchievementState {

  final String error;

  const AchievementLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AchievementLoadFailure { error: $error }';

}