import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class AchievementEvent extends Equatable {
  const AchievementEvent();

  @override
  List<Object> get props => [];
}

class LoadAchievement extends AchievementEvent {

  final int id;

  LoadAchievement([this.id]);

  @override
  // TODO: implement props
  List<Object> get props => ['Slug: $id'];


}