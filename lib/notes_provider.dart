import 'package:flutter/material.dart';

import 'db_helper.dart';

class NoteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> allNotes = [];
  String errorMsg = "";

  List<Map<String, dynamic>> get noteData => allNotes;

  void addNote(String title, String desc) async {
    var check = await DBHelper().addNote(title, desc);
    if (check > 0) {
      allNotes = await DBHelper().fetchNotes();
    } else {
      errorMsg = "Error";
    }
    notifyListeners();
  }

  void getNote() async {
    allNotes = await DBHelper().fetchNotes();
    notifyListeners();
  }

  void deleteNote(var index) async {
    var check = await DBHelper().deleteNote(index);
    if (check > 0) {
      allNotes = await DBHelper().fetchNotes();
    } else {
      errorMsg = "Error";
    }

    notifyListeners();
  }

  void updateNote(var id, var title, var desc) async {
    await DBHelper().updateNote(id, title, desc);
    notifyListeners();
  }
}
