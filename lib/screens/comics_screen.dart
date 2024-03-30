import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/comics/comics_bloc.dart';
import '../bloc/comics/comics_event.dart';
import '../bloc/comics/comics_state.dart';
import '../widgets/comics_card.dart';
import '../widgets/nav_bar.dart';
import '../config.dart'; // Assurez-vous que cette importation est correcte

class ComicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComicsBloc>(
      create: (context) => ComicsBloc()..add(FetchComicsEvent()),
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
                  'Comics les plus\npopulaires',
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
        body: BlocBuilder<ComicsBloc, ComicsState>(
          builder: (context, state) {
            if (state is ComicsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ComicsLoaded) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: state.comicsList.length,
                itemBuilder: (context, index) {
                  return ComicsCard(comics: state.comicsList[index], index: index);
                },
              );
            } else if (state is ComicsError) {
              return Center(child: Text(state.message));
            } else {
              // This is 'ComicsInitial' or any other state not accounted for above
              return Center(child: Text('Press a button to fetch comics.'));
            }
          },
        ),
      ),
    );
  }
}
