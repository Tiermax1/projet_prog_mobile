import 'package:flutter/material.dart';
import '../widgets/section_card.dart'; // Replace with your own card widget

Widget buildSection({
  required String title,
  required List<dynamic> items,
  required BuildContext context,
}) {
  return SliverToBoxAdapter(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
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
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFA500),
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(right: 8.0),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: implement see more functionality
                  },
                  child: Text(
                    'Voir plus',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF0F1E2B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 220.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return SectionCard(item: items[index]); // Use your own card widget
              },
            ),
          ),
        ],
      ),
    ),
  );
}