import 'package:flutter/material.dart';
import 'package:projet_prog_mobile/models/comic_detail.dart';

class HistoryTab extends StatelessWidget {
  final ComicDetail comicDetail;

  const HistoryTab({Key? key, required this.comicDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start of the screen
        children: [
          Text(
            comicDetail.description,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black, // Change text color to black (or any other color you need)
            ),
          ),
          // Add other Widgets for other details like issue number, publish date, etc.
          // You can use RichText for a combination of different styles
        ],
      ),
    );
  }
}
