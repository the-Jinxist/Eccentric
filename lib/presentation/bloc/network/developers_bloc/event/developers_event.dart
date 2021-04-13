import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class DevelopersEvent extends Equatable {
  const DevelopersEvent();

  @override
  List<Object> get props => [];
}

class LoadDevelopers extends DevelopersEvent {}