class NoteModel {
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
