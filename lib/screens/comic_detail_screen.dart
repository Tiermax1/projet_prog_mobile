import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_prog_mobile/bloc/comics/comic_detail_bloc.dart';
import 'package:projet_prog_mobile/bloc/comics/comic_detail_event.dart';
import 'package:projet_prog_mobile/bloc/comics/comic_detail_state.dart';
import 'package:projet_prog_mobile/models/comic_detail.dart';
import 'package:projet_prog_mobile/widgets/history_tab.dart';
import 'package:projet_prog_mobile/widgets/authors_tab.dart';
import 'package:projet_prog_mobile/widgets/characters_tab.dart';

import '../repository/comic_repository.dart';

class ComicDetailScreen extends StatelessWidget {
  final String apiDetailUrl;

  ComicDetailScreen({Key? key, required this.apiDetailUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComicDetailBloc>(
      create: (context) => ComicDetailBloc(
        comicRepository: RepositoryProvider.of<ComicRepository>(context),
      )..add(FetchComicDetailEvent(apiDetailUrl: apiDetailUrl)),
      child: Scaffold(
        body: BlocBuilder<ComicDetailBloc, ComicDetailState>(
          builder: (context, state) {
            if (state is ComicDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ComicDetailLoaded) {
              return DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 350.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            state.comicDetail.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                          background: Image.network(
                            state.comicDetail.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Container(
                    color: Colors.black,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          labelColor: Colors.red,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: 'Histoire'),
                            Tab(text: 'Auteurs'),
                            Tab(text: 'Personnages'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              HistoryTab(comicDetail: state.comicDetail),
                              AuthorsTab(creators: state.comicDetail.creators),
                              CharactersTab(characters: state.comicDetail.characters),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ComicDetailError) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return Center(child: Text('Unexpected state.'));
            }
          },
        ),
      ),
    );
  }
}
