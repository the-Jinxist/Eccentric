import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/developers_bloc/z_developers_bloc.dart';
import 'package:game_app/presentation/bloc/publishers_bloc/z_publishers_bloc.dart';

class DevelopersBloc extends Bloc<DevelopersEvent, DevelopersState>{

  DevelopersBloc() : super(DevelopersIdleState());

  @override
  Stream<DevelopersState> mapEventToState(DevelopersEvent event) async* {

    if(event is LoadDevelopers){

      yield DevelopersLoadInProgress();

      try{

        PublishersModel model  = await getPublishersService();
        yield DevelopersLoadSuccess(model);

      }catch(e){

        yield DevelopersLoadFailure(e.toString());


      }



    }

  }


}