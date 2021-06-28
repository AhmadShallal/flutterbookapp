import 'package:two/notes/notes.dart';

import '../BaseModel.dart';

class Note{
  int id;
  String title;
  String content;
  String color;

  Note(
      this.id,
      this.title,
      this.content,
      this.color,
      );

  @override
  String toString() {
    return 'Cases{id: $id, title: $title, content: $content, color:$color}';
  }

  factory Note.fromMap(Map<String, dynamic> json) {
    return Note(json['id'], json['title'], json['content'], json['color']);
  }
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(json['id'], json['title'], json['content'], json['color']);
  }
}

class NotesModel extends BaseModel{
  String color ='';

  void setColor( String inColor){
    color = inColor;
    notifyListeners();
  }
}

NotesModel notesModel = NotesModel();