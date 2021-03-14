import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class PublishersState extends Equatable {
  const PublishersState();

  @override
  List<Object> get props => [];
}

class PublishersIdleState extends PublishersState {}

class PublishersLoadInProgress extends PublishersState {}

class PublishersLoadSuccess extends PublishersState {
  final PublishersModel publishers;

  const PublishersLoadSuccess([this.publishers]);

  @override
  List<Object> get props => [publishers];

  @override
  String toString() => 'PublishersLoadSuccess { publishers: $publishers }';
}

class PublishersLoadFailure extends PublishersState {

  final String error;

  const PublishersLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AnticipatedLoadFailure { error: $error }';

}