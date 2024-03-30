import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilmsCard extends StatelessWidget {
  final Map<String, dynamic> film;
  final int index;

  FilmsCard({required this.film, required this.index});

  @override
  Widget build(BuildContext context) {
    String imageUrl = film['image']?['medium_url'] ?? 'assets/images/default_image.png';
    String name = film['name'] ?? 'Titre inconnu';
    String runtime = film['runtime']?.toString() ?? 'N/A';
    String releaseDate = film['release_date']?.toString() ?? 'N/A';
    String year = releaseDate.isNotEmpty ? releaseDate.substring(0, 4) : 'N/A';

    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: imageUrl.startsWith('http')
                    ? Image.network(
                  imageUrl,
                  width: 129,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('Image not available'));
                  },
                )
                    : Image.asset(
                  imageUrl,
                  width: 129,
                  height: 150,
                  fit: BoxFit.cover,
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        runtime + ' minutes',
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
        ],
      ),
    );
  }
}
