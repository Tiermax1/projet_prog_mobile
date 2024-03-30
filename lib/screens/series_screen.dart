import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../bloc/series/series_bloc.dart';
import '../bloc/series/series_event.dart';
import '../bloc/series/series_state.dart';
import '../widgets/series_card.dart';
import '../widgets/nav_bar.dart';

class SeriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeriesBloc>(
      create: (context) => SeriesBloc()..add(FetchSeriesEvent()),
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
                  'Séries les plus populaires',
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
        body: BlocBuilder<SeriesBloc, SeriesState>(
          builder: (context, state) {
            if (state is SeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SeriesLoaded) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: state.seriesList.length,
                itemBuilder: (context, index) {
                  return SeriesCard(series: state.seriesList[index], index: index);
                },
              );
            } else if (state is SeriesError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Press a button to fetch series.'));
            }
          },
        ),
      ),
    );
  }
}
