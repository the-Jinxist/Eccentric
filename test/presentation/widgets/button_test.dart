import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/widgets/button.dart';

void main(){

  Widget app;

  setUp((){

    app = MaterialApp(
      home: Scaffold(
        body: Builder(builder: (BuildContext context){

          Size size = MediaQuery.of(context).size;
          SizeConfig.init(context, width: size.width, height: size.height, allowFontScaling: true);

          return XButton(onClick: (){}, text: "XButton");

        }),
      ),
    );
  });

  testWidgets("Check to see if button text correlate", (WidgetTester tester) async {

    await tester.pumpWidget(app);

    final Finder textFinder = find.text("XButton");
    expect(textFinder, findsOneWidget);

  });

}