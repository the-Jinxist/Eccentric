import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class TrailersState extends Equatable {
  const TrailersState();

  @override
  List<Object> get props => [];
}

class TrailersIdleState extends TrailersState {}

class TrailersLoadInProgress extends TrailersState {}

class TrailersLoadSuccess extends TrailersState {
  final TrailersModel trailers;

  const TrailersLoadSuccess([this.trailers]);

  @override
  List<Object> get props => [trailers];

  @override
  String toString() => 'TrailersLoadSuccess { game: $trailers }';
}

class TrailersLoadFailure extends TrailersState {

  final String error;

  const TrailersLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TrailersLoadFailure { error: $error }';

}