import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/svg.dart';

import 'navBar.dart';
import 'config.dart';

class ComicsScreen extends StatefulWidget {
  @override
  _ComicsScreenState createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  List<dynamic> comicsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchComics();
  }

  Future<void> fetchComics() async {
    final String apiKey = Config.comicVineApiKey;
    // Note: Change the API endpoint to fetch comics instead of series
    final String apiUrl =
        'https://comicvine.gamespot.com/api/comics?api_key=$apiKey&format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          comicsList = data['results'];
          isLoading = false;
        });
      } else {
        print('Failed to load comics list');
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
      appBar: AppBar(
        backgroundColor: Color(0xFF15232E),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Comics les plus',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'populaires',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
            comic: comicsList[index],
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

class ComicsCard extends StatelessWidget {
  final Map<String, dynamic> comic;
  final int index;

  ComicsCard({required this.comic, required this.index});

  @override
  Widget build(BuildContext context) {
    String imageUrl = comic['image']?['medium_url'] ?? 'default_image_url';
    String title = comic['name'] ?? 'Unknown Title';
    // Pour les comics, vous pouvez avoir besoin d'attributs différents de ceux pour les séries.
    // Vérifiez votre réponse API pour les attributs corrects.
    String issueNumber = comic['issue_number']?.toString() ?? 'N/A'; // Exemple d'un autre attribut.
    // Les variables 'publisherName', 'episodes', et 'year' doivent être remplacées par des attributs appropriés de comics.

    return Card(
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
                          title, // Utilisez 'title' au lieu de 'name'
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
                          'Issue #$issueNumber', // Utilisez 'issueNumber'
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Vous pouvez ajouter plus de Text widgets pour d'autres informations
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
    );
  }
}// Assurez-vous que le widget NavBar est bien défini ailleurs dans votre code.