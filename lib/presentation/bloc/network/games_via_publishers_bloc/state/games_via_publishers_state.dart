import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class GamesViaPublishersState extends Equatable {
  const GamesViaPublishersState();

  @override
  List<Object> get props => [];
}

class GamesViaPublishersIdleState extends GamesViaPublishersState {}

class GamesViaPublishersLoadInProgress extends GamesViaPublishersState {}

class GamesViaPublishersLoadSuccess extends GamesViaPublishersState {
  final GamesModel games;

  const GamesViaPublishersLoadSuccess([this.games]);

  @override
  List<Object> get props => [games];

  @override
  String toString() => 'GamesViaPublishersLoadSuccess { games: $games}';
}

class GamesViaPublishersLoadFailure extends GamesViaPublishersState {

  final String error;

  const GamesViaPublishersLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GamesViaPublishersLoadFailure { error: $error }';

}