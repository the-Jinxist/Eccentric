import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class PlatformEvent extends Equatable {
  const PlatformEvent();

  @override
  List<Object> get props => [];
}

class LoadPlatform extends PlatformEvent {}