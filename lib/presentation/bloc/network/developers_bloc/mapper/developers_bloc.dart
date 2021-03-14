import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/z_datasources.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/network/developers_bloc/z_developers_bloc.dart';

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