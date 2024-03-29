import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'navBar.dart';
import 'config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> series = [];
  List<dynamic> comics = [];
  List<dynamic> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchSeries();
    await fetchComics();
    await fetchMovies();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchSeries() async {
    final String apiKey = Config.comicVineApiKey;
    final String seriesEndpoint = 'series_list'; // Ajustez selon l'API
    final String apiUrl =
        'https://comicvine.gamespot.com/api/$seriesEndpoint?api_key=$apiKey&format=json';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final result = json.decode(response.body)['results'];
        setState(() {
          series = result;
        });
      } else {
        throw Exception('Failed to load series');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchComics() async {
    final String apiKey = Config.comicVineApiKey;
    final String comicsEndpoint = 'issues'; // Ajustez selon l'API
    final String apiUrl =
        'https://comicvine.gamespot.com/api/$comicsEndpoint?api_key=$apiKey&format=json';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final result = json.decode(response.body)['results'];
        setState(() {
          comics = result;
        });
      } else {
        throw Exception('Failed to load comics');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchMovies() async {
    final String apiKey = Config.comicVineApiKey;
    final String moviesEndpoint = 'movies'; // Ajustez selon l'API
    final String apiUrl =
        'https://comicvine.gamespot.com/api/$moviesEndpoint?api_key=$apiKey&format=json';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final result = json.decode(response.body)['results'];
        setState(() {
          movies = result;
        });
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the status bar height
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: statusBarHeight + 20), // Adjust the space for the status bar
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
                      'assets/images/astronaut.svg', // Correct path to your SVG image
                      height: 80, // Adjust the size of the astronaut image
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add your sliver list content after the header
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Replace with your actual content widgets
                buildSection(
                  title: 'Séries populaires',
                  items: series,
                  context: context,
                ),
                buildSection(
                  title: 'Comics populaires',
                  items: comics,
                  context: context,
                ),
                buildSection(
                  title: 'Films populaires',
                  items: movies,
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection({
    required String title,
    required List<dynamic> items,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFA500),
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(right: 8.0),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Action pour "Voir plus"
                  },
                  child: Text(
                    'Voir plus',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF0F1E2B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height:
                220.0, // Augmentez la hauteur pour accommoder le titre en dessous de l'image
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final imageUrl =
                    item['image']?['medium_url']; // Ceci peut être null.
                // Modification ici pour la logique de détermination du nom
                String name;
                if (item.containsKey('volume')) { // Supposons que cela indique un comic
                  name = item['volume']['name'];
                } else { // Pour films et séries
                  name = item['name'];
                }

                return Container(
                  width: 150, // Ajustez la largeur si nécessaire
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF2D4455),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: Image.network(
                                // item['image']['medium_url'],
                                imageUrl,
                                width: 150, // Ajustez la largeur si nécessaire
                                height: 160, // Ajustez la hauteur si nécessaire
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 150,
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.grey, // Placeholder color
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                              ),
                              child:
                                  Icon(Icons.broken_image), // Placeholder icon
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          name ?? 'Titre inconnu',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
