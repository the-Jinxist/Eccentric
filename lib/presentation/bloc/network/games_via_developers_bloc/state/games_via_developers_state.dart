import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class GamesViaDevelopersState extends Equatable {
  const GamesViaDevelopersState();

  @override
  List<Object> get props => [];
}

class GamesViaDeveloperIdleState extends GamesViaDevelopersState {}

class GamesViaDevelopersLoadInProgress extends GamesViaDevelopersState {}

class GamesViaDevelopersLoadSuccess extends GamesViaDevelopersState {
  final GamesModel games;

  const GamesViaDevelopersLoadSuccess([this.games]);

  @override
  List<Object> get props => [games];

  @override
  String toString() => 'GamesViaDevelopersLoadSuccess { games: $games}';
}

class GamesViaDevelopersLoadFailure extends GamesViaDevelopersState {

  final String error;

  const GamesViaDevelopersLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GamesViaDevelopersLoadFailure { error: $error }';

}