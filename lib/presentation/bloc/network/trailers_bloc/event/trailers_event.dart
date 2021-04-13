import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class TrailersEvent extends Equatable {
  const TrailersEvent();

  @override
  List<Object> get props => [];
}

class LoadTrailers extends TrailersEvent {

  final String slug;

  LoadTrailers([this.slug]);

  @override
  // TODO: implement props
  List<Object> get props => ['Slug: $slug'];


}