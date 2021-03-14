import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchIdleState extends SearchState {}

class SearchLoadInProgress extends SearchState {}

class SearchLoadSuccess extends SearchState {
  final GamesModel games;

  const SearchLoadSuccess([this.games]);

  @override
  List<Object> get props => [games];

  @override
  String toString() => 'SearchLoadSuccess { game: $games }';
}

class SearchLoadFailure extends SearchState {

  final String error;

  const SearchLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SearchLoadFailure { error: $error }';

}