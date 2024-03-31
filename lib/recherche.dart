import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'navBar.dart'; // Remplacez ceci par le chemin d'accès correct de votre NavBar personnalisée

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  List<String> searchResults = []; // Liste des résultats de recherche

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

  void onSearch() {
    setState(() {
      isSearching = true;
    });
    // Simuler une recherche en attente
    Future.delayed(Duration(seconds: 2), () {
      // Simuler des résultats de recherche
      setState(() {
        isSearching = false;
        searchResults = ["Titans", "Young Justice: Outsiders"]; // Résultats factices
      });
    });
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
          : buildSearchInput(context, scaleFactor)),
      bottomNavigationBar: NavBar(onItemSelected: (index) {
        // Logique de navigation ou mise à jour de l'interface utilisateur
      }),
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
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(searchResults[index]));
      },
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
