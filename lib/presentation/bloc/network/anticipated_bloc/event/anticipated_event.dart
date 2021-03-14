import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class AnticipatedEvent extends Equatable {
  const AnticipatedEvent();

  @override
  List<Object> get props => [];
}

class LoadAnticipated extends AnticipatedEvent {}
