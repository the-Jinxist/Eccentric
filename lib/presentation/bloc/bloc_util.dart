import 'package:game_app/presentation/bloc/z_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final blocs = [
  BlocProvider<AnticipatedBloc>(
    create: (context) => AnticipatedBloc(),
  ),
  BlocProvider<AchievementBloc>(
    create: (context) => AchievementBloc(),
  ),
  BlocProvider<DetailsBloc>(
    create: (context) => DetailsBloc(),
  ),
  BlocProvider<DevelopersBloc>(
    create: (context) => DevelopersBloc(),
  ),
  BlocProvider<GamesViaDevelopersBloc>(
    create: (context) => GamesViaDevelopersBloc(),
  ),
  BlocProvider<GamesViaPlatformBloc>(
    create: (context) => GamesViaPlatformBloc(),
  ),
  BlocProvider<GamesViaPublishersBloc>(
    create: (context) => GamesViaPublishersBloc(),
  ),
  BlocProvider<GenresBloc>(
    create: (context) => GenresBloc(),
  ),
  BlocProvider<PlatformBloc>(
    create: (context) => PlatformBloc(),
  ),
  BlocProvider<PopularBloc>(
    create: (context) => PopularBloc(),
  ),
  BlocProvider<PublishersBloc>(
    create: (context) => PublishersBloc(),
  ),
  BlocProvider<ScreenshotBloc>(
    create: (context) => ScreenshotBloc(),
  ),
  BlocProvider<SearchBloc>(
    create: (context) => SearchBloc(),
  ),
  BlocProvider<TrailersBloc>(
    create: (context) => TrailersBloc(),
  ),
  BlocProvider<YourGamesBloc>(
    create: (context) => YourGamesBloc(),
  ),
];