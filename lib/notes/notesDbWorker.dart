// TODO Implement this library.

import 'package:path/path.dart';
import 'package:two/notes/notes.dart';
import '../utils.dart';
import 'notesModel.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class ApiWorker{
  final String apiUrl = 'api/notes';

  Future<List<Note>> getNotes() async {
    Response res = await get(apiUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Note> notes = body.map((dynamic item) => Note.fromJson(item)).toList();
      return notes;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Note> getCaseById(String id) async {
    final response = await get('$apiUrl/$id');

    if (response.statusCode == 200) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Note> createCase(Note note) async {
    Map data = {
      'title': note.title,
      'content': note.content,
      'color': note.color
    };

    final Response response = await post(
      apiUrl,
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

  Future<Note> updateCases(String id, Note note) async {
    Map data = {
      'title': note.title,
      'content': note.content,
      'color': note.color
    };

    final Response response = await put(
      '$apiUrl/$id',
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

  Future<void> deleteCase(String id) async {
    Response res = await delete('$apiUrl/$id');

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }
}



