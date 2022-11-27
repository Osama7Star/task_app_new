import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'custome_widget/app_bar.dart';
import 'custome_widget/bottom_bar.dart';
import 'main_page.dart';
import 'notes_page.dart';

class FavouriteTask extends StatelessWidget {
   FavouriteTask({Key? key}) : super(key: key);


  Query dbRef = FirebaseDatabase.instance.ref().child('Tasks');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Tasks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: [
          SizedBox(
            height: 500,
            child: FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map task = snapshot.value as Map;
                task['key'] = snapshot.key;

              bool show = task['isFavorite']=="1"?true:false;

                return  show?NoteWidget(task: task):SizedBox();
              },
            ),
          )
        ],
      ),

      bottomNavigationBar:
      const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
