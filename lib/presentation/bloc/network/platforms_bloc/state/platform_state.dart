import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class PlatformState extends Equatable {
  const PlatformState();

  @override
  List<Object> get props => [];
}

class PlatformIdleState extends PlatformState {}

class PlatformLoadInProgress extends PlatformState {}

class PlatformLoadSuccess extends PlatformState {
  final PlatformModel platforms;

  const PlatformLoadSuccess([this.platforms]);

  @override
  List<Object> get props => [platforms];

  @override
  String toString() => 'AnticipatedLoadSuccess { game: $platforms }';
}

class PlatformLoadFailure extends PlatformState {

  final String error;

  const PlatformLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PlatformLoadFailure { error: $error }';

}