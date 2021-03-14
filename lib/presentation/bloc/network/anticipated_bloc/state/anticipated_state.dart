import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class AnticipatedState extends Equatable {
  const AnticipatedState();

  @override
  List<Object> get props => [];
}

class AnticipatedIdleState extends AnticipatedState {}

class AnticipatedLoadInProgress extends AnticipatedState {}

class AnticipatedLoadSuccess extends AnticipatedState {
  final GamesModel games;

  const AnticipatedLoadSuccess([this.games]);

  @override
  List<Object> get props => [games];

  @override
  String toString() => 'AnticipatedLoadSuccess { game: $games }';
}

class AnticipatedLoadFailure extends AnticipatedState {

  final String error;

  const AnticipatedLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AnticipatedLoadFailure { error: $error }';

}