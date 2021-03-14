import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

  @override
  List<Object> get props => [];
}

class LoadPopular extends PopularEvent {}