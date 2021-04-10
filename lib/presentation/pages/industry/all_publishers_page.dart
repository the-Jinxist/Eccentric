
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/category/publishers_page.dart';
import 'package:game_app/presentation/view/publisher_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';
import 'package:game_app/presentation/widgets/y_margin.dart';

class AllPublishersPage extends StatefulWidget {
  @override
  _AllPublishersPageState createState() => _AllPublishersPageState();
}

class _AllPublishersPageState extends State<AllPublishersPage> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PublishersBloc>(context).add(LoadPublishers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: SizeConfig.screenHeightDp,
        width: SizeConfig.screenWidthDp,
        child: SingleChildScrollView(
          child: Column(
            children: [
              YMargin(50),
              TitleText(text: "Publishers", ),
              NormalText(text: "The best of tha best!", ),
              YMargin(15),
              BlocBuilder<PublishersBloc, PublishersState>(
                  builder: (BuildContext context, PublishersState state) {
                    if (state is PublishersLoadInProgress) {
                      return Container(
                        height: SizeConfig.screenHeightDp - 200,
                        width: SizeConfig.screenWidthDp,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is PublishersLoadSuccess) {
                      return ListView.builder(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          itemCount: state.publishers.results.length,
                          itemBuilder: (context, position){
                            var model = state.publishers.results[position];
                            return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PublishersPage(model)));
                                },
                                child: Container(margin: EdgeInsets.only(bottom: 5, top: 5),child: PublisherView(model, "publishers"))
                            );
                          }
                      );
                    } else if (state is PublishersLoadFailure) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        height: SizeConfig.screenHeightDp - 200,
                        width: SizeConfig.screenWidthDp,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              NormalText(text: "Sorry an error occured", textAlign: TextAlign.center,),
                              GestureDetector(
                                onTap: (){
                                  BlocProvider.of<PublishersBloc>(context).add(LoadPublishers());
                                },
                                child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25,),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: SizeConfig.screenHeightDp - 200,
                        width: SizeConfig.screenWidthDp,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

}
