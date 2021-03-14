import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState>{

  GenresBloc() : super(GenresIdleState());

  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {

    if(event is LoadGenres){

      try{
        yield GenresLoadInProgress();
        GenreModel model = await getGenresService();
        String genreString  = await getGenreString();

        yield GenresLoadSuccess(model, genreString != null ? genreString.split(", "): null);

      }catch(e){

        yield GenresLoadFailure();

      }

    }else if(event is SaveGenres){

      try{
        await setGenreString(event.genresString);
        yield SaveGenresSuccess();

      }catch(e){

        yield SaveGenresFailure();

      }
    }

  }


}