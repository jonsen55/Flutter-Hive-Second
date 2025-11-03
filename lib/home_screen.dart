import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_second/boxes/boxes.dart';
import 'package:hive_second/models/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database Example'),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _){
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index){
            return Card(
              child: Column(
                children: [
                  Text(data[index].title.toString()),
                ],
              ),
            );
          });
        }
      // Column(
      //   children: [
          // FutureBuilder(future: Hive.openBox('jonsen'), builder: (context, snapshot){
          //   return  Column(
          //     children: [
          //       ListTile(
          //         title: Text(snapshot.data!.get('name').toString()),
          //         subtitle: Text(snapshot.data!.get('pro').toString()),
          //         trailing: IconButton(onPressed: (){
          //           snapshot.data!.put('name', 'jonsen holaa rw');
          //           setState(() {
                      
          //           });
          //         }, icon: Icon(Icons.edit)),
          //       )
          //       ,
          //     ],
          //   );
          // })
        // ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // var box = await Hive.openBox('jonsen');
          // box.put('name', 'jonsen gaire');
          // box.put('pro', 'Flutter intern');
          // box.put('details', {
          //   'age' : 19,
          //   'address' : 'Pokhara',
          //   'College' : 'Informatics College Pokhara'
          // });
          _showMyDialog();

        },
        child: Icon(Icons.add),
      )
    );
    
  }
  Future<void> _showMyDialog() async{
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter title',
                      border: OutlineInputBorder(

                      )
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter your description',
                      border: OutlineInputBorder(

                      )
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                final data = NotesModel(title: titleController.text, description: descriptionController.text);
                final box = Boxes.getData();
                box.add(data);
                data.save();
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },child: Text('Add'),
              ),
              TextButton(onPressed: (){
                Navigator.pop(context);
              },child: Text('Cancel'),
              )
            ],
          );
        }
      );
    }
}