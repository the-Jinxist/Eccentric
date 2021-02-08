import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/presentation/bloc/popular_bloc/z_popular_bloc.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState>{

  PopularBloc(PopularState initialState) : super(initialState);

  @override
  Stream<PopularState> mapEventToState(PopularEvent event) {

  }



}