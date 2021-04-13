import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];

}

class LoadDetails extends DetailsEvent {

  final int id;

  LoadDetails([this.id]);

  @override
  List<Object> get props => [id];

  @override
  String toString () => "Game Details: $id";

}
