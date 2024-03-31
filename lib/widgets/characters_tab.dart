import 'package:flutter/material.dart';
import 'package:projet_prog_mobile/models/character.dart';

class CharactersTab extends StatelessWidget {
  final List<Character> characters;

  CharactersTab({Key? key, required this.characters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return ListTile(
          leading: Image.network(character.imageUrl),
          title: Text(character.name),
        );
      },
    );
  }
}
