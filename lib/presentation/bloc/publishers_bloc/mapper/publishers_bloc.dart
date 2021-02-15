import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/datasources/api/rawg_api.dart';
import 'package:game_app/domain/models/zmodels.dart';
import 'package:game_app/presentation/bloc/publishers_bloc/z_publishers_bloc.dart';

class PublishersBloc extends Bloc<PublishersEvent, PublishersState>{

  PublishersBloc() : super(PublishersIdleState());

  @override
  Stream<PublishersState> mapEventToState(PublishersEvent event) async* {

    if(event is LoadPublishers){

      yield PublishersLoadInProgress();

      try{

        PublishersModel model  = await getPublishersService();
        yield PublishersLoadSuccess(model);

      }catch(e){

        yield PublishersLoadFailure(e.toString());


      }



    }

  }


}