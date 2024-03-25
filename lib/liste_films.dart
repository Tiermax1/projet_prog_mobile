import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/svg.dart';

import 'navBar.dart'; // Votre NavBar personnalisée
import 'config.dart'; // Votre configuration

class FilmsScreen extends StatefulWidget {
  @override
  _FilmScreenState createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmsScreen> {
  List<dynamic> filmsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilms();
  }

  Future<void> fetchFilms() async {
    final String apiKey = Config.comicVineApiKey;
    final String apiUrl =
        'https://comicvine.gamespot.com/api/films_list?api_key=$apiKey&format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          filmsList = data['results'];
          isLoading = false;
        });
      } else {
        print('Failed to load films list');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception caught: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Vous pouvez ajuster ceci pour augmenter la hauteur de l'AppBar.
        child: AppBar(
          backgroundColor: Color(0xFF15232E),
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 34.0), // Ajustez l'espacement ici selon votre capture d'écran.
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Films les plus populaires', // Utilisez les styles de votre capture d'écran.
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontSize: 30, // La taille de la police de votre capture d'écran.
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20),
        itemCount: filmsList.length,
        itemBuilder: (context, index) {
          return FilmsCard(
            films: filmsList[index],
            index: index,
          );
        },
      ),
      bottomNavigationBar: NavBar(onItemSelected: (index) {
        // Interaction logic here
      }),
    );
  }
}

class FilmsCard extends StatelessWidget {
  final Map<String, dynamic> films;
  final int index;

  FilmsCard({required this.films, required this.index});

  @override
  Widget build(BuildContext context) {
    // Tailles définies à partir de la capture d'écran
    final double cardWidth = 359.0;
    final double cardHeight = 164.0;

    String imageUrl = films['image']?['medium_url'] ?? 'default_image_url';
    String name = films['name'] ?? 'Unknown Title';
    String publisherName = films['publisher']?['name'] ?? 'Unknown';
    String episodes = films['count_of_episodes']?.toString() ?? 'N/A';
    String year = films['start_year']?.toString() ?? 'N/A';

    return Container(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Color(0xFF1E3243),
        child: Stack(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Text('Image not available'));
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            publisherName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Épisodes: $episodes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Année: $year',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '#${index + 1}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}