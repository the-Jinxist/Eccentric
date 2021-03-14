import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class GamesViaPublishersEvent extends Equatable {
  const GamesViaPublishersEvent();

  @override
  List<Object> get props => [];
}

class LoadGamesViaPublishers extends GamesViaPublishersEvent {

  final String publishers;

  LoadGamesViaPublishers([this.publishers]);

  @override
  List<Object> get props => [publishers];

  @override
  String toString () => "LoadGamesViaPublishers: $publishers";

}