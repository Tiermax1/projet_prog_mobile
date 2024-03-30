import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../bloc/comics/comics_bloc.dart';
import '../bloc/comics/comics_event.dart';
import '../bloc/comics/comics_state.dart';
import '../bloc/movies/movies_bloc.dart';
import '../bloc/movies/movies_event.dart';
import '../bloc/movies/movies_state.dart';
import '../bloc/series/series_bloc.dart';
import '../bloc/series/series_event.dart';
import '../bloc/series/series_state.dart';
import '../widgets/build_section.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ComicsBloc>(
          create: (context) => ComicsBloc()..add(FetchComicsEvent()),
        ),
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc()..add(FetchMoviesEvent()),
        ),
        BlocProvider<SeriesBloc>(
          create: (context) => SeriesBloc()..add(FetchSeriesEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFF15232E),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Bienvenue !',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SvgPicture.asset(
                        'assets/images/astronaut.svg',
                        height: 80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildSectionBloc<SeriesBloc, SeriesState>('Séries populaires'),
            buildSectionBloc<ComicsBloc, ComicsState>('Comics populaires'),
            buildSectionBloc<MoviesBloc, MoviesState>('Films populaires'),

          ],
        ),
      ),
    );
  }

  Widget buildSectionBloc<B extends BlocBase<S>, S>(String title) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        if (state is ComicsLoading || state is MoviesLoading || state is SeriesLoading) {
          return SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
        } else if (state is ComicsLoaded || state is MoviesLoaded || state is SeriesLoaded) {
          // Cast sûr en utilisant la vérification de type et en accédant à l'attribut correct
          var items = (state is ComicsLoaded)
              ? state.comicsList // Utilisez l'attribut correct ici
              : (state is MoviesLoaded)
              ? state.moviesList // Supposons qu'il y a un attribut similaire pour les films
              : (state as SeriesLoaded).seriesList; // Et un pour les séries
          return buildSection(
            title: title,
            items: items,
            context: context,
          );
        } else if (state is ComicsError || state is MoviesError || state is SeriesError) {
          var message = (state is ComicsError)
              ? state.message // Utilisez l'attribut correct ici
              : (state is MoviesError)
              ? state.message // Supposons qu'il y a un message pour les erreurs de films
              : (state as SeriesError).message; // Et un pour les erreurs de séries
          return SliverFillRemaining(child: Center(child: Text(message)));
        } else {
          return SliverFillRemaining(child: Center(child: Text('Aucun élément à afficher')));
        }
      },
    );
  }
}
