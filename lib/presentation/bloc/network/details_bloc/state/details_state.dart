import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsIdleState extends DetailsState {}

class DetailsLoadInProgress extends DetailsState {}

class DetailsLoadSuccess extends DetailsState {
  final GameDetailModel gamesDetails;

  const DetailsLoadSuccess([this.gamesDetails]);

  @override
  List<Object> get props => [gamesDetails];

  @override
  String toString() => 'DetailsLoadSuccess { details: $gamesDetails }';
}

class DetailsLoadFailure extends DetailsState {

  final String error;

  const DetailsLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'DetailsLoadFailure { error: $error }';

}