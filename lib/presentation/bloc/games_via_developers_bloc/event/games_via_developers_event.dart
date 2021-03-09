import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class GamesViaDevelopersEvent extends Equatable {
  const GamesViaDevelopersEvent();

  @override
  List<Object> get props => [];
}

class LoadGamesViaDevelopers extends GamesViaDevelopersEvent {

  final String developers;

  LoadGamesViaDevelopers([this.developers]);

  @override
  List<Object> get props => [developers];

  @override
  String toString () => "Developers: $developers";

}