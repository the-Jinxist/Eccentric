import 'package:equatable/equatable.dart';
import 'package:game_app/domain/models/zmodels.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadSearch extends SearchEvent {

  final String searchQuery;

  LoadSearch([this.searchQuery]);

  @override
  // TODO: implement props
  List<Object> get props => ['Search Query: $searchQuery'];


}