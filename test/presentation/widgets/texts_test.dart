import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/bloc_util.dart';
import 'package:game_app/presentation/widgets/texts.dart';

void main() {

  Widget normalTextApp;
  Widget accentTextApp;
  Widget titleTextApp;

  setUp(() {

    normalTextApp = MultiBlocProvider(
        providers: blocs,
        child: MaterialApp(
          home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              Size size = MediaQuery.of(context).size;
              SizeConfig.init(context,
                  width: size.width,
                  height: size.height,
                  allowFontScaling: true);

              return NormalText(text: "Arcade");
            }),
          ),
        ));

    titleTextApp = MultiBlocProvider(
        providers: blocs,
        child: MaterialApp(
          home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              Size size = MediaQuery.of(context).size;
              SizeConfig.init(context,
                  width: size.width,
                  height: size.height,
                  allowFontScaling: true);

              return TitleText(text: "Arcade");
            }),
          ),
        ));

    accentTextApp = MultiBlocProvider(
        providers: blocs,
        child: MaterialApp(
          home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              Size size = MediaQuery.of(context).size;
              SizeConfig.init(context,
                  width: size.width,
                  height: size.height,
                  allowFontScaling: true);

              return AccentText(text: "Arcade");
            }),
          ),
        ));

  });

  group("Testing texts", (){

    testWidgets("Check to see if normal widget text correlates",
            (WidgetTester tester) async {
      await tester.pumpWidget(normalTextApp);

      final Finder textFinder = find.text("Arcade");
      expect(textFinder, findsOneWidget);
    });

    testWidgets("Check to see if title widget text correlates",
            (WidgetTester tester) async {
          await tester.pumpWidget(titleTextApp);

          final Finder textFinder = find.text("Arcade");
          expect(textFinder, findsOneWidget);
        });

    testWidgets("Check to see if accent widget text correlates",
            (WidgetTester tester) async {
          await tester.pumpWidget(accentTextApp);

          final Finder textFinder = find.text("Arcade");
          expect(textFinder, findsOneWidget);
        });

  });

}
