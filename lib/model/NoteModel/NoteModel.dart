class NoteModel {
  NoteModel(
      {required this.title,
      this.date,
      required this.description,
      required this.color});
  String title;
  String? date;
  String description;
  int color;
}
