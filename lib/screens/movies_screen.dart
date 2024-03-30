import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movies/movies_bloc.dart';
import '../bloc/movies/movies_event.dart';
import '../bloc/movies/movies_state.dart';
import '../widgets/movies_card.dart';
import '../widgets/nav_bar.dart';

class FilmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      create: (context) => MoviesBloc()..add(FetchMoviesEvent()),
      child: Scaffold(
        backgroundColor: Color(0xFF15232E),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Color(0xFF15232E),
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 34.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Films les plus\npopulaires',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MoviesLoaded) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: state.moviesList.length,
                itemBuilder: (context, index) {
                  return FilmsCard(film: state.moviesList[index], index: index);
                },
              );
            } else if (state is MoviesError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Press a button to fetch movies.'));
            }
          },
        ),

    ),
    );
  }
}
