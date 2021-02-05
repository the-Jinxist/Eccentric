import 'package:equatable/equatable.dart';

abstract class YourGamesEvent extends Equatable {
  const YourGamesEvent();

  @override
  List<Object> get props => [];
}

class LoadYourGames extends YourGamesEvent {}