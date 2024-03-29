import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import 'navBar.dart'; // Votre NavBar personnalisée
import 'config.dart'; // Assurez-vous que cette importation est correcte

class FilmsScreen extends StatefulWidget {
  @override
  _FilmsScreenState createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsScreen> {
  List<dynamic> filmsList = [];
  final Color backgroundColor = Color(0xFF15232E);
  final Color cardBackgroundColor = Color(0xFF1E3243);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilms();
  }

  Future<void> fetchFilms() async {
    final String apiKey = Config.comicVineApiKey;
    // Assurez-vous que cette URL est correcte et conforme à la documentation de l'API
    final String apiUrl = 'https://comicvine.gamespot.com/api/movies?api_key=$apiKey&format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          filmsList = data['results'];
          isLoading = false;
        });
      } else {
        print('Failed to load films: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Failed to load films: $e');
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
        preferredSize: Size.fromHeight(
            100.0), // Vous pouvez ajuster ceci pour augmenter la hauteur de l'AppBar.
        child: AppBar(
          backgroundColor: Color(0xFF15232E),
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(
                left: 32.0,
                top:
                    34.0), // Ajustez l'espacement ici selon votre capture d'écran.
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Films les plus\npopulaires', // Utilisez les styles de votre capture d'écran.
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontSize:
                      30, // La taille de la police de votre capture d'écran.
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

    );
  }
}

class FilmsCard extends StatelessWidget {
  final Map<String, dynamic> films;
  final int index;

  FilmsCard({required this.films, required this.index});

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        films['image']?['medium_url'] ?? 'assets/images/default_image.png';
    String name = films['name'] ?? 'Titre inconnu';
    String time = films['runtime']?.toString() ?? 'N/A';
    String releaseDate = films['release_date']?.toString() ?? 'N/A';
    String year = releaseDate.isNotEmpty ? releaseDate.substring(0, 4) : 'N/A';
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF1E3243), // Adjusted the color to match the design
        borderRadius: BorderRadius.circular(
            10), // Adjusted the radius to match the design
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            top: (150 - 133) / 2, // Centering the image vertically
            left: 22, // Position from the left as per design
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Rounded corners as per design
              child: Image.network(
                imageUrl,
                width: 129, // Width as per design
                height: 133, // Height as per design
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Image not available'));
                },
              ),
            ),
          ),
          Positioned(
            left: 150, // Assuming the image plus some padding to the right
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10), // Padding inside the container
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/ic_movie_bicolor.svg',
                        width: 14,
                        height: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      SizedBox(width: 8),
                      Text(
                        time + ' minutes',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/ic_calendar_bicolor.svg',
                        width: 14,
                        height: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      SizedBox(width: 8),
                      Text(
                        year,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '#${index + 1}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
