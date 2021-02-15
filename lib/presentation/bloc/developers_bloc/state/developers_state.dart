import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class DevelopersState extends Equatable {
  const DevelopersState();

  @override
  List<Object> get props => [];
}

class DevelopersIdleState extends DevelopersState {}

class DevelopersLoadInProgress extends DevelopersState {}

class DevelopersLoadSuccess extends DevelopersState {
  final PublishersModel developers;

  const DevelopersLoadSuccess([this.developers]);

  @override
  List<Object> get props => [developers];

  @override
  String toString() => 'DevelopersLoadSuccess { developers: $developers }';
}

class DevelopersLoadFailure extends DevelopersState {

  final String error;

  const DevelopersLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AnticipatedLoadFailure { error: $error }';

}