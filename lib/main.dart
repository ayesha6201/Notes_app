import 'package:flutter/material.dart';
import 'all_notes_pages.dart';
import 'notes_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()
        )
      ],
    child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: homepage()
    );
  }
}

class homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => homepageState();
}

class homepageState extends State<homepage> {
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Note App"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [Colors.indigo.shade300, Colors.red.shade300],
                end: Alignment.bottomLeft)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: TextField(
                  controller: titleController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      label: Text(
                        "Title : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide:
                          BorderSide(color: Colors.black, width: 2))),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: descController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    label: Text(
                      "Description : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.black, width: 2))),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        var title = titleController.text.toString();
                        var desc = descController.text.toString();

                        context.read<NoteProvider>().addNote(title, desc);



                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Added Note Successfully!')));

                        titleController.text = '';
                        descController.text = '';
                      },
                      child: Text(
                        'ADD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllNotes(),
                            ));
                      },
                      child: Text(
                        'ALL NOTES',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
