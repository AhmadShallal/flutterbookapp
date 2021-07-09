// TODO Implement this library.

import 'package:path/path.dart';
import 'package:two/notes/notes.dart';
import '../utils.dart';
import 'notesModel.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class ApiWorker{
  var apiUrl = 'api/notes';

  Future<List<Note>> getAll() async {
    Response res = await get(Uri.parse(apiUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Note> notes = body.map((dynamic item) => Note.fromJson(item)).toList();
      return notes;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Note> getNoteById(int id) async {
    final response = await get(Uri.parse("$apiUrl/$id"));

    if (response.statusCode == 200) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Note> createNote(Note note) async {
    Map data = {
      'title': note.title,
      'content': note.content,
      'color': note.color
    };

    final Response response = await post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Note> updateNotes(Note note) async {
    Map data = {
      'title': note.title,
      'content': note.content,
      'color': note.color
    };

    final Response response = await put(
      Uri.parse('$apiUrl'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteNote(String id) async {
    Response res = await delete(Uri.parse('$apiUrl/$id'));

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }
}



