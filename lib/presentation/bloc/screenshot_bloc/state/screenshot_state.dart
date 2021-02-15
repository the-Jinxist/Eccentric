import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class ScreenshotState extends Equatable {
  const ScreenshotState();

  @override
  List<Object> get props => [];
}

class ScreenshotIdleState extends ScreenshotState {}

class ScreenshotLoadInProgress extends ScreenshotState {}

class ScreenshotLoadSuccess extends ScreenshotState {
  final ScreenshotsModel screenshots;

  const ScreenshotLoadSuccess([this.screenshots]);

  @override
  List<Object> get props => [screenshots];

  @override
  String toString() => 'ScreenshotLoadSuccess { screenshots: $screenshots }';
}

class ScreenshotLoadFailure extends ScreenshotState {

  final String error;

  const ScreenshotLoadFailure([this.error]);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ScreenshotLoadFailure { error: $error }';

}