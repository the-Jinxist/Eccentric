import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class GamesViaPlatformState extends Equatable {
  const GamesViaPlatformState();

  @override
  List<Object> get props => [];
}

class GamesViaPlatformIdleState extends GamesViaPlatformState {}

class GamesViaPlatformLoadInProgress extends GamesViaPlatformState {}

class GamesViaPlatformLoadSuccess extends GamesViaPlatformState {
  final GamesModel gamesDetails;

  const GamesViaPlatformLoadSuccess([this.gamesDetails]);

  @override
  List<Object> get props => [gamesDetails];

  @override
  String toString() => 'GamesViaPlatformLoadSuccess { details: $gamesDetails }';
}

class GamesViaPlatformLoadFailure extends GamesViaPlatformState {

  final String error;

  const GamesViaPlatformLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GamesViaPlatformLoadFailure { error: $error }';

}