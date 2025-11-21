import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_second/home_screen.dart';
import 'package:hive_second/models/notes_model.dart';
import 'package:path_provider/path_provider.dart';

/// This function initializes the Hive database and registers the adapter
/// for the NotesModel. It then runs the MyApp widget.
void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  
  Hive.registerAdapter(NotesModelAdapter());
  Hive.openBox<NotesModel>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen()
    );
  }
}
