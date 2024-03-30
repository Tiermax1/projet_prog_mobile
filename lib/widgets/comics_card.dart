import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ComicsCard extends StatelessWidget {
  final Map<String, dynamic> comics;
  final int index;

  ComicsCard({required this.comics, required this.index});

  @override
  Widget build(BuildContext context) {
    String imageUrl = comics['image']?['medium_url'] ?? 'assets/images/default_image.png';
    String name = comics['volume']?['name'] ?? 'Titre inconnu';
    String description = comics['name'] ?? 'N/A';
    String issueNumber = comics['issue_number']?.toString() ?? 'N/A';
    String year = comics['cover_date']?.split('-')[0] ?? 'N/A';

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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                child: imageUrl.startsWith('http')
                    ? Image.network(
                  imageUrl,
                  width: 129,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: SvgPicture.asset('assets/images/placeholder.svg', fit: BoxFit.cover));
                  },
                )
                    : Image.asset(
                  imageUrl, // Assuming you have a placeholder image in your assets
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
                  decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    '#${index + 1}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_books_bicolor.svg', width: 14, height: 14, color: Colors.white70),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          description,
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_books_bicolor.svg', width: 14, height: 14, color: Colors.white70),
                      SizedBox(width: 8),
                      Text(
                        'Issue #$issueNumber',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_calendar_bicolor.svg', width: 14, height: 14, color: Colors.white70),
                      SizedBox(width: 8),
                      Text(
                        'Year: $year',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
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
