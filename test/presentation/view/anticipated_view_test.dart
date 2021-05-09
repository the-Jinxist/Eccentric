
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_app/domain/models/games_model.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/view/anticipated_view.dart';

void main(){

  Widget app;
  Result testResult = Result(
    added: 0,
    addedByStatus: {},
    backgroundImage: "http://placehold.it/120x120&text=image1",
    id: 0,
    metacritic: 2,
    name: "Anticipated Test",
    playtime: 20,
    rating: 4.0,
    ratings: {},
    ratingsCount: 25,
    ratingsTop: 5,
    released: "20th of May,",
    reviewsTextCount: 25,
    slug: "anticipated test",
    suggestionsCount: 12,
    tba: true
  );

  setUp((){

    //In order to use widgets that do a http connection
    HttpOverrides.global = null;

    app = MaterialApp(
      home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            Size size = MediaQuery.of(context).size;
            SizeConfig.init(context,
                width: size.width,
                height: size.height,
                allowFontScaling: true);

            return AnticipatedView(testResult);
          })
      ),
    );

  });

  group("Anticipated view tests", (){

    testWidgets("Test to correlate text", (WidgetTester tester) async {

      //runAsync is used to make sure the http connection doesn't fail the test
      await tester.runAsync(() async {
        await tester.pumpWidget(app);

        final Finder textFinder = find.text("Anticipated Test");
        expect(textFinder, findsOneWidget);
      });


    });

    testWidgets("Test to make sure the rating widget is present", (WidgetTester tester) async {

      //runAsync is used to make sure the http connection doesn't fail the test
      await tester.runAsync(() async {
        await tester.pumpWidget(app);

        final Finder textFinder = find.byType(RatingBar);
        expect(textFinder, findsOneWidget);
      });


    });

  });

}