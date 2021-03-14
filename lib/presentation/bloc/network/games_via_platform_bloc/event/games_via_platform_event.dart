import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class GamesViaPlatformEvent extends Equatable {
  const GamesViaPlatformEvent();

  @override
  List<Object> get props => [];

}

class LoadGamesViaPlatforms extends GamesViaPlatformEvent {

  final String platform;

  LoadGamesViaPlatforms([this.platform]);

  @override
  List<Object> get props => [platform];

  @override
  String toString () => "LoadGamesViaPlatforms: $platform";

}
