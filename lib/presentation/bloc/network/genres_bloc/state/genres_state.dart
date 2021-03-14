import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object> get props => [];
}

class GenresIdleState extends GenresState {}

class GenresLoadInProgress extends GenresState {}

class GenresLoadSuccess extends GenresState {
  final GenreModel genres;
  final List<String> alreadyAddedGenres;

  const GenresLoadSuccess([this.genres, this.alreadyAddedGenres]);

  @override
  List<Object> get props => [genres];

  @override
  String toString() => 'GenresLoadSuccess { genres: $genres }';

}

class GenresLoadFailure extends GenresState {}


class SaveGenresSuccess extends GenresState{}

class SaveGenresFailure extends GenresState {}