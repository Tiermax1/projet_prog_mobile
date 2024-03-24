import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/svg.dart';

import 'navBar.dart'; // Votre NavBar personnalisée
import 'config.dart'; // Votre configuration

class SeriesScreen extends StatefulWidget {
  @override
  _SeriesScreenState createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  List<dynamic> seriesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSeries();
  }

  Future<void> fetchSeries() async {
    final String apiKey = Config.comicVineApiKey;
    final String apiUrl =
        'https://comicvine.gamespot.com/api/series_list?api_key=$apiKey&format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          seriesList = data['results'];
          isLoading = false;
        });
      } else {
        print('Failed to load series list');
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
      appBar: AppBar( // Il manquait 'appBar:' ici.
        backgroundColor: Color(0xFF15232E),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0), // Ajoutez l'espace souhaité en haut
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Séries les plus',
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
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20),
        itemCount: seriesList.length,
        itemBuilder: (context, index) {
          return SeriesCard(
            series: seriesList[index],
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

class SeriesCard extends StatelessWidget {
  final Map<String, dynamic> series;
  final int index;

  SeriesCard({required this.series, required this.index});

  @override
  Widget build(BuildContext context) {
    String imageUrl = series['image']?['medium_url'] ?? 'default_image_url';
    String name = series['name'] ?? 'Unknown Title';
    String publisherName = series['publisher']?['name'] ?? 'Unknown';
    String episodes = series['count_of_episodes']?.toString() ?? 'N/A';
    String year = series['start_year']?.toString() ?? 'N/A';

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
    );
  }
}

// Assurez-vous que le widget NavBar est bien défini ailleurs dans votre code.