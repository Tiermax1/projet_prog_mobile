import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/comics.dart';

class SectionCard extends StatelessWidget {
  final dynamic item;

  SectionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    String imageUrl;
    String name;

    if (item is Comics) {
      imageUrl = item.imageUrl ?? 'assets/images/default_image.png';
      // Correct access for the Comics class instance
      name = item.volume['name'] ?? 'Titre inconnu'; // Assuming volume is a map.
    } else {
      // Correcting access to the name property for map instances
      imageUrl = item['image']?['medium_url'] ?? 'assets/images/default_image.png';
      name = item['name'] ?? 'Titre inconnu'; // Corrected bracket notation for accessing map values
    }

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
            child: imageUrl.startsWith('http') ? Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                  child: SvgPicture.asset('assets/images/placeholder.svg')
              ),
            ) : Image.asset(
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