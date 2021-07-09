import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'utils.dart' as utils;
import 'tasks/tasks.dart';
import 'notes/notes.dart';
import 'contacts/contacts.dart';
import 'appointments/appointments.dart';


void main() {
  startApp() async{
    //Directory docsDirectory = await getApplicationDocumentsDirectory();
    //utils.docsDir = docsDirectory;
    runApp(FlutterBookApp());
  }

  startApp();
}

class FlutterBookApp extends StatelessWidget {
  Widget build(BuildContext inContext) {
    return MaterialApp(
        home : DefaultTabController(
            length : 4,
            child : Scaffold(
                appBar : AppBar(
                    title : Text("FlutterBook"),
                    bottom : TabBar(
                        tabs : [
                          Tab(icon : Icon(Icons.date_range),
                              text : "Appointments"),
                          Tab(icon : Icon(Icons.contacts),
                              text : "Contacts"),
                          Tab(icon : Icon(Icons.note),
                              text : "Notes"),
                          Tab(icon : Icon(Icons.assignment_turned_in),
                              text : "Tasks")
                        ]
                    )
                ),

                body : TabBarView(
                children : [
                Appointments(), Contacts(), Notes(), Tasks()
            ]
        )
    )
    )
    );
  }
}
