import 'package:hive_flutter/adapters.dart';
part 'NoteModel.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  NoteModel(
      {required this.title,
      required this.date,
      required this.description,
      required this.color});
  @HiveField(1)
  String title;
  @HiveField(2)
  String date;
  @HiveField(3)
  String description;
  @HiveField(4)
  int color;
}

/*class NoteModel {
  NoteModel(
      {required this.title,
      this.date,
      required this.description,
      required this.color, required id});
  int? id;
  String title;
  String? date;
  String description;
  int color;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'color': color,
    };
  }
}
*/