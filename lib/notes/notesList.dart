// TODO Implement this library.

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import "package:flutter_slidable/flutter_slidable.dart";
import 'notesDbWorker.dart';
import 'notesModel.dart' show Note, NotesModel, notesModel;

class NotesList extends StatelessWidget {


  Widget build(BuildContext context) {
    return ScopedModel<NotesModel>(
        model: notesModel,
        child: ScopedModelDescendant<NotesModel>(
            builder:(BuildContext inContext, Widget inChild,  NotesModel inModel) {
                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add,color: Colors.white),
                    onPressed: (){
                      notesModel.entityBeingEdited = Note;
                      notesModel.setColor('');
                      notesModel.setStackIndex(1);

                    },
                  ),
                  body: ListView.builder(
                  itemCount: notesModel.entityList.length,
                  itemBuilder: (BuildContext inBuildContext, int inIndex){
                    Note note = notesModel.entityList[inIndex];
                    Color color = Colors.white;
                    switch(note.color){
                      case "red": color = Colors.red; break;
                      case "green": color = Colors.green; break;
                      case "blue": color = Colors.blue; break;
                      case "yellow": color = Colors.yellow; break;
                      case "grey": color = Colors.grey; break;
                      case "purple": color = Colors.purple; break;
                    }
                    return Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Slidable(
                      actionPane:SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      secondaryActions: [
                        IconSlideAction(
                          caption: "Delete?",
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap:() => _deleteNote(inContext,note),
                        )
                      ],


                      child: Card(
                        elevation: 8,color: color,
                        child: ListTile(
                          title: Text("${note.title}"),
                          subtitle: Text("${note.content}"),
                          onTap: () async{
                            notesModel.entityBeingEdited = await ApiWorker().getNoteById(note.id);
                            notesModel.setColor(notesModel.entityBeingEdited.color);
                            notesModel.setStackIndex(1);
                          },
                        ),
                      ),

                    ),
                    );
                  }
                  ),
                );
            }
            )

    );
  }

  Future _deleteNote(BuildContext inContext, Note inNote) {
      return showDialog(
          context: inContext,
          barrierDismissible: false,
          builder: (BuildContext inAlertContext){
            return AlertDialog(
              title: Text("Delete Note"),
              content: Text("Are you sure you want to delete ${inNote.title}"),
              actions: [
                TextButton(onPressed: (){Navigator.of(inAlertContext).pop();},
                     child: Text("Cancel")),
                TextButton(child: Text("Delete"),onPressed: () async {
                  await ApiWorker().deleteNote(inNote.id.toString());
                  Navigator.of(inAlertContext).pop();
                  Scaffold.of(inContext).showSnackBar(
                      SnackBar(
                          backgroundColor : Colors.red,
                          duration : Duration(seconds : 2),
                          content : Text("Note deleted")
                      )
                          
                  );
                  notesModel.loadData('notes', ApiWorker);
                }
                )
              ],
            );
          }
      );
  }
}
