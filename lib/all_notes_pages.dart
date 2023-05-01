import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app_provider/notes_provider.dart';

import 'package:provider/provider.dart';

import 'db_helper.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({Key? key}) : super(key: key);

  @override
  State<AllNotes> createState() => AllNotesState();
}

class AllNotesState extends State<AllNotes> {
  List<Map<String, dynamic>> arrNotes = [];

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Notes'),
      ),
      body: SingleChildScrollView(
        child: Consumer<NoteProvider>(
          builder: (_, Provider, __) {
            arrNotes = Provider.allNotes;

            return StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: Provider.allNotes.reversed
                  .map(
                    (note) => StaggeredGridTile.count(
                      crossAxisCellCount:
                          note[DBHelper().ColumnId] % 3 == 0 ? 4 : 2,
                      mainAxisCellCount: 2,
                      child: InkWell(
                        onLongPress: () {
                          showDeleteDialog(note);
                        },
                        onTap: () {
                          showUpdateNoteDialog(note);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    note[DBHelper().ColumnTitle].toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  note[DBHelper().ColumnDesc].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  showDeleteDialog(note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Are you sure you want to delete this note?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              context
                  .read<NoteProvider>()
                  .deleteNote(note[DBHelper().ColumnId]);
              getAllData();
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  showUpdateNoteDialog(note) {
    title.text = note[DBHelper().ColumnTitle].toString();
    desc.text = note[DBHelper().ColumnDesc].toString();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: title,
              ),
              TextFormField(
                controller: desc,
              ),
              ElevatedButton(
                onPressed: () async {
                  context.read<NoteProvider>().updateNote(
                      note[DBHelper().ColumnId], title.text, desc.text);

                  title.text;
                  desc.text;

                  getAllData();
                  Navigator.pop(context);
                },
                child: Text(
                  'UPDATE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void getAllData() async {
    context.read<NoteProvider>().getNote();
  }
}
