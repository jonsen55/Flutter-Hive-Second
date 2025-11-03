import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database Example'),
      ),
      body: Column(
        children: [
          FutureBuilder(future: Hive.openBox('jonsen'), builder: (context, snapshot){
            return  Column(
              children: [
                ListTile(
                  title: Text(snapshot.data!.get('name').toString()),
                  subtitle: Text(snapshot.data!.get('pro').toString()),
                  trailing: IconButton(onPressed: (){
                    snapshot.data!.put('name', 'jonsen holaa rw');
                    setState(() {
                      
                    });
                  }, icon: Icon(Icons.edit)),
                )
                ,
              ],
            );
          })
        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var box = await Hive.openBox('jonsen');
          box.put('name', 'jonsen gaire');
          box.put('pro', 'Flutter intern');
          box.put('details', {
            'age' : 19,
            'address' : 'Pokhara',
            'College' : 'Informatics College Pokhara'
          });

        },
        child: Icon(Icons.add),
      ),
      

    );

  }
}