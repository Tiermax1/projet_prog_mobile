import 'package:flutter/material.dart';
import 'package:projet_prog_mobile/models/person.dart';

class AuthorsTab extends StatelessWidget {
  final List<Person> creators;

  AuthorsTab({Key? key, required this.creators}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: creators.length,
      itemBuilder: (context, index) {
        final creator = creators[index];
        return ListTile(
          leading: Image.network(creator.imageUrl),
          title: Text(creator.name),
          subtitle: Text(creator.country),
        );
      },
    );
  }
}
