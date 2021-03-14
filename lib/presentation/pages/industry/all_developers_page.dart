
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:game_app/presentation/pages/category/developers_page.dart';
import 'package:game_app/presentation/view/publisher_view.dart';
import 'package:game_app/presentation/widgets/texts.dart';

class AllDevelopersPage extends StatefulWidget {
  @override
  _AllDevelopersPageState createState() => _AllDevelopersPageState();
}

class _AllDevelopersPageState extends State<AllDevelopersPage> {


  @override
  void initState() {
    super.initState();

    BlocProvider.of<DevelopersBloc>(context).add(LoadDevelopers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TitleText(text: "Developers", ),
            NormalText(text: "The hard workers! Whew!", ),
          ],
        ),
      ), preferredSize: Size.fromHeight(100)),
      body: Column(
        children: [
          BlocBuilder<DevelopersBloc, DevelopersState>(
              builder: (BuildContext context, DevelopersState state) {
                if (state is DevelopersLoadInProgress) {
                  return Container(
                    height: SizeConfig.screenHeightDp,
                    width: SizeConfig.screenWidthDp,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is DevelopersLoadSuccess) {
                  return ListView.builder(
                      padding: EdgeInsets.only(left: 10, right: 5),
                      itemCount: state.developers.results.length,
                      itemBuilder: (context, position){
                        var model = state.developers.results[position];
                        return InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DevelopersPage(model)));
                            },
                            child: Container(margin: EdgeInsets.only(bottom: 5, top: 5),child: PublisherView(model, "developers"))
                        );
                      }
                  );
                } else if (state is DevelopersLoadFailure) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    height: SizeConfig.screenHeightDp,
                    width: SizeConfig.screenWidthDp,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          NormalText(text: "Sorry an error occured",textAlign: TextAlign.center,),
                          GestureDetector(
                            onTap: (){
                              BlocProvider.of<DevelopersBloc>(context).add(LoadDevelopers());
                            },
                            child: TitleText(text: "Reload", textColor: Colors.orange, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: SizeConfig.screenHeightDp,
                    width: SizeConfig.screenWidthDp,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

}
