import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularIdleState extends PopularState {}

class PopularLoadInProgress extends PopularState {}

class PopularLoadSuccess extends PopularState {
  final GamesModel games;

  const PopularLoadSuccess([this.games]);

  @override
  List<Object> get props => [games];

  @override
  String toString() => 'AnticipatedLoadSuccess { game: $games }';
}

class PopularLoadFailure extends PopularState {

  final String error;

  const PopularLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AnticipatedLoadFailure { error: $error }';

}