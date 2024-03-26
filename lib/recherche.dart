import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'navBar.dart'; // Ensure this is the correct import for your custom NavBar

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Assuming 375 is the width based on the design specification provided
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
            fontSize: 30,
          ),
        ),
        backgroundColor: Color(0xFF223141),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFF15232E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF223141),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20 * scaleFactor), // Adjust radius according to screen size
                  bottomRight: Radius.circular(20 * scaleFactor),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13 * scaleFactor, vertical: 20 * scaleFactor),
                child: TextFormField(
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
                      borderRadius: BorderRadius.circular(35.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20 * scaleFactor), // Spacing between elements
            Container(
              width: 348 * scaleFactor,
              padding: EdgeInsets.all(13 * scaleFactor),
              decoration: BoxDecoration(
                color: Color(0xFF1E3243),
                borderRadius: BorderRadius.circular(20 * scaleFactor), // Rounded corner radius
              ),
              child: Text(
                'Saisissez une recherche pour trouver un comics, film, série ou personnage.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1F9FFF),
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.normal,
                  fontSize: 15 * scaleFactor, // Text size
                  height: 1.333, // Line height
                ),
              ),
            ),
            SizedBox(height: 20 * scaleFactor), // Spacing between elements
            SvgPicture.asset(
              'assets/images/astronaut.svg', // Replace with your actual image asset path
              width: 74.02 * scaleFactor, // Scale factor applied to the width
              height: 97 * scaleFactor, // Scale factor applied to the height
            ),
            // ... any other widgets you want to include
          ],
        ),
      ),
      bottomNavigationBar: NavBar(onItemSelected: (index) {
        // Mettez à jour l'interface utilisateur ou naviguez vers une nouvelle page
      }), // Your custom bottom navigation bar
    );
  }
}