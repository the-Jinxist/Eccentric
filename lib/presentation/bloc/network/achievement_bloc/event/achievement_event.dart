import 'package:equatable/equatable.dart';

abstract class AchievementEvent extends Equatable {
  const AchievementEvent();

  @override
  List<Object> get props => [];
}

class LoadAchievement extends AchievementEvent {

  final int id;

  LoadAchievement([this.id]);

  @override
  List<Object> get props => ['Slug: $id'];


}