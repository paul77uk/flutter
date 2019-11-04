import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType()
class Contact {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final String occupation;

  Contact(this.name, this.age, this.occupation);
}
