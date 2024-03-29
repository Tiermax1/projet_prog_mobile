import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import 'navBar.dart'; // Votre NavBar personnalisée
import 'config.dart'; // Assurez-vous que cette importation est correcte

class ComicsScreen extends StatefulWidget {
  @override
  _ComicsScreenState createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  List<dynamic> comicsList = [];
  final Color backgroundColor = Color(0xFF15232E); // Couleur de fond de l'écran
  final Color cardBackgroundColor =
  Color(0xFF1E3243); // Couleur de fond des cartes
  bool isLoading = true; // Indicateur de chargement
  @override
  void initState() {
    super.initState();
    fetchComics();
  }
  int _selectedIndex = 0;

  void _onNavItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> fetchComics() async {
    final String apiKey = Config.comicVineApiKey;
    final String apiUrl =
        'https://comicvine.gamespot.com/api/issues?api_key=$apiKey&format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Vérifiez la structure de la réponse avec un débogage
        print(data);
        // Mettez à jour l'état avec les nouvelles données
        setState(() {
          comicsList = data['results'];
          isLoading =
          false; // Données chargées, mise à jour de l'état de chargement
        });
      } else {
        // Si le code d'état n'est pas 200, il y a une erreur
        print('Failed to load comics: ${response.statusCode}');
        setState(() {
          isLoading =
          false; // Mise à jour de l'état de chargement en cas d'erreur
        });
      }
    } catch (e) {
      // Si une exception est lancée, imprimez-la et mettez à jour l'état de chargement
      print('Failed to load comics: $e');
      setState(() {
        isLoading =
        false; // Mise à jour de l'état de chargement en cas d'exception
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
                'Comics les plus populaires', // Utilisez les styles de votre capture d'écran.
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
        itemCount: comicsList.length,
        itemBuilder: (context, index) {
          return ComicsCard(
            comics: comicsList[index],
            index: index,
          );
        },
      ),

    );
  }
}

class ComicsCard extends StatelessWidget {
  final Map<String, dynamic> comics;
  final int index;

  ComicsCard({required this.comics, required this.index});

  @override
  Widget build(BuildContext context) {
    String imageUrl = comics['image']?['medium_url'] ?? 'assets/images/default_image.png';
    String name = comics['volume']['name'] ?? 'Titre inconnu';
    String description = comics['name'] ?? 'N/A';
    String numero = comics['issue_number']?.toString() ?? 'N/A';
    String year = comics['cover_date']?.toString() ?? 'N/A';

    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF1E3243), // Adjusted the color to match the design
        borderRadius: BorderRadius.circular(10), // Adjusted the radius to match the design
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            top: (150 - 133) / 2, // Centering the image vertically
            left: 22, // Position from the left as per design
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Rounded corners as per design
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
              padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10), // Padding inside the container
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
                      Text(
                        description,
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
                        'assets/images/ic_books_bicolor.svg',
                        width: 14,
                        height: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'N°' + numero,
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