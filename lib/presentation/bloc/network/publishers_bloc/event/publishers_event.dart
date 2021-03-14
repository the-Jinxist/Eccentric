import 'package:equatable/equatable.dart';

abstract class PublishersEvent extends Equatable {
  const PublishersEvent();

  @override
  List<Object> get props => [];
}

class LoadPublishers extends PublishersEvent {}