import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'notesDbWorker.dart';
import 'notesList.dart';
import 'notesEntry.dart';
import 'notesModel.dart' show NotesModel, notesModel;

class Notes extends StatelessWidget{
  Notes(){
    notesModel.loadData("notes",ApiWorker);
  }

  Widget build(BuildContext inContext){
    return ScopedModel<NotesModel>(
        model: notesModel,
        child: ScopedModelDescendant<NotesModel>(
          builder: (BuildContext inContext,Widget inChild,NotesModel inModel){
            return IndexedStack(
              index: inModel.stackIndex,
              children: [NotesList(),NotesEntry()],
            );
          },
        )
    );
  }
}