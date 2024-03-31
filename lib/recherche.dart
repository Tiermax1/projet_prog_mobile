import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets/nav_bar.dart'; // Remplacez ceci par le chemin d'accès correct de votre NavBar personnalisée
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class SearchResult {
  final String title;
  final String imageUrl;
  final String category;

  SearchResult({required this.title, required this.imageUrl, required this.category});
}

Future<List<SearchResult>> searchMovies(String query) async {
  final String apiUrl = 'https://comicvine.gamespot.com/api/movies?api_key=${Config.comicVineApiKey}&format=json&filter=name:$query';
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Transforme les résultats en une liste d'objets SearchResult
      List<SearchResult> searchResults = (data['results'] as List).map((movie) {
        return SearchResult(
          title: movie['name'], // Assume que 'name' est le titre du film
          imageUrl: movie['image']['medium_url'], // Utilise 'medium_url' pour l'image, ajuste si nécessaire
          category: 'Films', // Définit la catégorie des résultats
        );
      }).toList();

      return searchResults;
    } else {
      print('Échec du chargement des films: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Échec du chargement des films: $e');
    return [];
  }
}


Future<List<SearchResult>> searchSeries(String query) async {
  final String apiKey = Config.comicVineApiKey;
  final String apiUrl = 'https://comicvine.gamespot.com/api/search/?api_key=$apiKey&format=json&query=$query&resources=series';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Transforme les résultats en une liste d'objets SearchResult
      List<SearchResult> seriesResults = (data['results'] as List).map((series) {
        // Fais des vérifications ici pour t'assurer que les données existent
        String imageUrl = series['image'] != null ? series['image']['medium_url'] : '';
        return SearchResult(
          title: series['name'],
          imageUrl: imageUrl, // Utilise une image par défaut si l'url n'est pas disponible
          category: 'Séries',
        );
      }).toList();

      return seriesResults;
    } else {
      print('Échec du chargement des séries: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Échec du chargement des séries: $e');
    return [];
  }
}

Future<List<SearchResult>> searchComics(String query) async {
  final String apiUrl = 'https://comicvine.gamespot.com/api/issues?api_key=${Config.comicVineApiKey}&format=json&filter=name:$query';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<SearchResult> comicResults = [];

      for (var comic in data['results']) {
        // Pour chaque comic trouvé, extrait les informations nécessaires
        String title = comic['name'] ?? 'Titre inconnu';
        String imageUrl = comic['image'] != null ? comic['image']['medium_url'] : 'https://via.placeholder.com/150';
        // Création d'un objet SearchResult pour chaque comic
        comicResults.add(SearchResult(
          title: title,
          imageUrl: imageUrl,
          category: 'Comics',
        ));
      }

      return comicResults;
    } else {
      print('Échec du chargement des comics: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Échec du chargement des comics: $e');
    return [];
  }
}



class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  List<SearchResult> searchResults = [];
  // Liste des résultats de recherche

  @override
  void initState() {
    super.initState();
    // Ajouter des listeners ou de la logique d'initialisation si nécessaire
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void onSearch() async {
    setState(() {
      isSearching = true;
      searchResults.clear(); // Efface les résultats précédents
    });

    // Lance toutes les recherches en parallèle et attend leur achèvement
    try {
      final results = await Future.wait([
        searchMovies(_searchController.text),
        searchSeries(_searchController.text),
        searchComics(_searchController.text),
      ]);

      // Combine tous les résultats en une liste unique
      final allResults = results.expand((x) => x).toList();

      setState(() {
        searchResults = allResults;
      });
    } catch (error) {
      // Gérer l'erreur ici, par exemple en affichant un message
      print("Erreur lors de la recherche: $error");
    } finally {
      setState(() {
        isSearching = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 375;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recherche',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 30 * scaleFactor,
          ),
        ),
        backgroundColor: Color(0xFF223141),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFF15232E),
      body: isSearching
          ? buildLoadingScreen(scaleFactor)
          : (searchResults.isNotEmpty
          ? buildResultsList()
          : buildSearchInput(context, scaleFactor)), // Afficher les résultats si disponibles

    );
  }

  Widget buildLoadingScreen(double scaleFactor) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Utilise 80% de la largeur de l'écran
        padding: EdgeInsets.all(10* scaleFactor), // Ajuste l'espacement intérieur
        decoration: BoxDecoration(
          color: Color(0xFF1E3243), // Couleur d'arrière-plan
          borderRadius: BorderRadius.circular(20 * scaleFactor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100 * scaleFactor, // Ajuste la taille de l'astronaute
              height: 100 * scaleFactor,
              child: SvgPicture.asset(
                'assets/images/astronaut.svg',
              ),
            ),
            SizedBox(height: 40 * scaleFactor), // Espace entre l'astronaute et le texte
            Text(
              'Recherche en cours.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20 * scaleFactor, // Taille de la police ajustée
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12 * scaleFactor), // Espace entre les deux textes
            Text(
              'Merci de patienter...',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16 * scaleFactor, // Taille de la police ajustée
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultsList() {
    // Grouper les résultats de recherche par catégorie
    Map<String, List<SearchResult>> groupedResults = {
      'Films': [],
      'Séries': [],
      'Comics': [],
    };

    for (var result in searchResults) {
      groupedResults[result.category]?.add(result);
    }

    return ListView(
      children: groupedResults.entries.map((entry) {
        return buildSection(
          title: '${entry.key} populaires',
          items: entry.value,
        );
      }).toList(),
    );
  }


  Widget buildSection({
    required String title,
    required List<SearchResult> items,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E3243), // La couleur de fond pour chaque catégorie
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
                        color: Color(0xFFFFA500), // La couleur de l'icône de point
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(right: 8.0),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                SearchResult item = items[index];
                return Container(
                  width: 140, // La largeur de chaque carte pour les éléments
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Les coins arrondis pour les cartes
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget buildSearchInput(BuildContext context, double scaleFactor) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF223141),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20 * scaleFactor),
              bottomRight: Radius.circular(20 * scaleFactor),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13 * scaleFactor, vertical: 20 * scaleFactor),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Comic, film, série...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontFamily: 'Nunito',
                  fontSize: 17 * scaleFactor,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                prefixIcon: Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0 * scaleFactor),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.white70),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
              onFieldSubmitted: (value) {
                // Lorsque l'utilisateur soumet sa recherche
                onSearch();
              },
            ),
          ),
        ),
        Spacer(),
        Container(
          width: double.infinity, // Prend toute la largeur possible
          padding: EdgeInsets.only(
            left: 25 * scaleFactor,
            top: 20 * scaleFactor,
            right: 25 * scaleFactor, // Espace à droite pour le texte
            bottom: 20 * scaleFactor,
          ),
          decoration: BoxDecoration(
            color: Color(0xFF1E3243),
            borderRadius: BorderRadius.circular(20 * scaleFactor),
          ),
          child: Stack(
            clipBehavior: Clip.none, // Permet aux éléments de déborder du container
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: 80 * scaleFactor, // Cet espace est réservé à droite du texte
                ),
                child: Align(
                  alignment: Alignment.centerLeft, // Aligner le texte à gauche
                  child: Text(
                    'Saisissez une recherche pour trouver un comics, film, série ou personnage.',
                    style: TextStyle(
                      color: Color(0xFF1F9FFF),
                      fontFamily: 'Nunito',
                      fontSize: 18 * scaleFactor,
                      height: 1.333,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -10 * scaleFactor, // Décale légèrement l'astronaute vers la droite
                top: -55 * scaleFactor, // Décale légèrement l'astronaute vers le haut
                child: SvgPicture.asset(
                  'assets/images/astronaut.svg',
                  width: 74.02 * scaleFactor,
                  height: 97 * scaleFactor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20 * scaleFactor),
        Spacer(),
        // Ajoutez d'autres widgets ici au besoin
      ],
    );
  }
}
