import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  var noteTable = 'note';
  var ColumnId = 'note_id';
  var ColumnTitle = 'note_title';
  var ColumnDesc = 'note_desc';

  Future<Database> openDB() async {
    var directory = await getApplicationDocumentsDirectory();

    directory.create(recursive: true);

    var path = "${directory.path}notes_db.db";

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          'create table $noteTable ($ColumnId integer primary key autoincrement,'
              '$ColumnTitle text,'
              '$ColumnDesc text)');
    });
  }

  Future<int> addNote(String title, String desc) async {
    var myDB = await openDB();
    return myDB.insert(noteTable, {ColumnTitle: title, ColumnDesc: desc});
  }

  Future<List<Map<String, dynamic>>> fetchNotes() async {
    var myDB = await openDB();
    return myDB.query(noteTable);
  }

  Future<int>deleteNote(var id)async{
    var myDB = await openDB();
    return myDB.delete(noteTable, where: "$ColumnId = $id");
  }


  Future<int> updateNote(var id, var title, var desc) async {
    var myDB = await openDB();
    return myDB.update(noteTable, { ColumnTitle: title, ColumnDesc: desc } , where: "$ColumnId = $id" );
  }
}
