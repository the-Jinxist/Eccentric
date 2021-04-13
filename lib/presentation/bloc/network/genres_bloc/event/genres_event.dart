import 'package:equatable/equatable.dart';

abstract class GenresEvent extends Equatable {
  const GenresEvent();

  @override
  List<Object> get props => [];
}

class LoadGenres extends GenresEvent {}

class SaveGenres extends GenresEvent{
  final String genresString;

  SaveGenres([this.genresString]);

  @override
  List<Object> get props => [genresString];

  @override
  String toString () => "Save genres: $genresString";

}