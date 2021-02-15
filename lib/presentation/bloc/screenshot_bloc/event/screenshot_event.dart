import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class ScreenshotEvent extends Equatable {
  const ScreenshotEvent();

  @override
  List<Object> get props => [];
}

class LoadScreenshot extends ScreenshotEvent {

  final String slug;

  LoadScreenshot([this.slug]);

  @override
  // TODO: implement props
  List<Object> get props => ['Slug: $slug'];


}