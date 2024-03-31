import 'package:projet_prog_mobile/models/person.dart';

class Character {
  late final String id;
  late final String imageUrl;
  late final String name;
  late final String apiDetailUrl;
  late final String description;
  late final String realName;
  late final List<String> aliases;
  late final String publisher;
  late final List<Person> creators;
  late final String gender;
  late final String birth;

  Character({
    required this.id,
    required this.name,
    required this.apiDetailUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    String id = json['id']?.toString() ?? '0000';
    String name = json['name']?.toString() ?? 'Unknown';
    String apiDetailUrl = json['api_detail_url']?.toString() ?? 'Unknown';

    return Character(
      id: id,
      name: name,
      apiDetailUrl: apiDetailUrl,
    );
  }
}