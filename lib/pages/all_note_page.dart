import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:task_app/pages/custome_widget/text.dart';
import '../utilities/colors.dart';
import '../utilities/sizes.dart';
import 'custome_widget/app_bar.dart';

import 'custome_widget/bottom_bar.dart';
import 'no_task.dart';
import 'notes_page.dart';

class AllNotePage extends StatefulWidget {
  const AllNotePage({Key? key}) : super(key: key);

  @override
  State<AllNotePage> createState() => _AllNotePageState();
}

class _AllNotePageState extends State<AllNotePage> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Tasks');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Tasks');


  late DatabaseReference _dbref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Current Task",fontSize: 20,color: Colors.blue),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: Container(
                        height: double.infinity,

                        child:
                        FirebaseAnimatedList(
                          query: dbRef,
                          itemBuilder: (BuildContext context, DataSnapshot snapshot,
                              Animation<double> animation, int index) {
                            Map task = snapshot.value as Map;
                            task['key'] = snapshot.key;
                            int length = 0 ;
                            if (task['isFinished']=='0')
                              length++;



                            return  length>0? NoteWidget(task: task):SizedBox(height:100,child: NoTask());
                          },
                        )

                    ),
                  ),
                ],
              ),
            ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                CustomText(text: "Completed",fontSize: 20,color: Colors.blue),
                SizedBox(height: 20),

                Container(
                    height: 200,
                    child: FirebaseAnimatedList(
                      query: dbRef,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map task = snapshot.value as Map;
                        task['key'] = snapshot.key;



                        return  FinishedNote(task: task);
                      },
                    ))
              ],
            ),
          )
          ],
        ),
      bottomNavigationBar:
      const CustomBottomNavBar(selectedMenu: MenuState.home),);
  }
}
