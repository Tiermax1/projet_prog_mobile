import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SectionCard extends StatelessWidget {
  final dynamic item;

  SectionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    // Ici, nous supposons que 'item' a des clés comme 'name' et 'image' pour simplifier.
    // Vous devrez peut-être ajuster ces clés en fonction de la structure de vos données.
    String imageUrl = item['image']?['medium_url'] ?? 'assets/images/default_image.png';
    String name;
    if (item.containsKey('volume')) { // Supposons que cela indique un comic
      name = item['volume']['name'];
    } else { // Pour films et séries
      name = item['name'];
    }
    // Assurez-vous d'avoir une icône 'placeholder.svg' dans vos assets si l'image est manquante.
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Color(0xFF2D4455),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: imageUrl.startsWith('http')
                ? Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: SvgPicture.asset('assets/images/placeholder.svg'));
              },
            )
                : Image.asset(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.white,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
