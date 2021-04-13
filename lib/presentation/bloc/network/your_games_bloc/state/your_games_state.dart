import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class YourGamesState extends Equatable {
  const YourGamesState();

  @override
  List<Object> get props => [];
}

class YourGamesIdleState extends YourGamesState {}

class YourGamesLoadInProgress extends YourGamesState {}

class YourGamesLoadSuccess extends YourGamesState {
  final GamesModel games;

  const YourGamesLoadSuccess([this.games]);

  @override
  List<Object> get props => [games];

  @override
  String toString() => 'AnticipatedLoadSuccess { game: $games }';
}

class YourGamesLoadFailure extends YourGamesState {

  final String error;

  const YourGamesLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AnticipatedLoadFailure { error: $error }';

}