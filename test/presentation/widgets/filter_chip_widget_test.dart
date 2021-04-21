import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/bloc/bloc_util.dart';
import 'package:game_app/presentation/widgets/filter_chip_widget.dart';

void main() {
  Widget app;
  List<String> alreadySelectedGenres = <String>[];
  String slug = "arcade";
  List<String> genreList = <String>[];

  int originalLength = genreList.length;

  setUp(() {
    app = MultiBlocProvider(
        providers: blocs,
        child: MaterialApp(
          home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              Size size = MediaQuery.of(context).size;
              SizeConfig.init(context,
                  width: size.width,
                  height: size.height,
                  allowFontScaling: true);

              return FilterChipWidget(
                  "Arcade", genreList, slug, alreadySelectedGenres);
            }),
          ),
        ));
  });

  testWidgets("Check to see if chip widget text correlate",
      (WidgetTester tester) async {
    await tester.pumpWidget(app);

    final Finder textFinder = find.text("Arcade");
    expect(textFinder, findsOneWidget);
  });

  testWidgets("New genre slug is added and removed on tap",
      (WidgetTester tester) async {
    await tester.pumpWidget(app);

    final chipFinder = find.byType(FilterChipWidget);
    expect(chipFinder, findsOneWidget);

    await tester.tap(chipFinder);
    await tester.pumpAndSettle();

    expect(genreList.length, originalLength + 1);

    await tester.tap(chipFinder);
    await tester.pumpAndSettle();

    expect(genreList.length, originalLength);
  });
}
