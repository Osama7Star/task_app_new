import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import 'custome_widget/app_bar.dart';
import 'custome_widget/bottom_bar.dart';
import 'custome_widget/text.dart';
import 'main_page.dart';

class NoteDetails extends StatefulWidget {
   NoteDetails({Key? key,required this.taskKey}) : super(key: key);
  String taskKey;

  @override
  State<NoteDetails> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetails> {

  Query dbRef = FirebaseDatabase.instance.ref().child('Tasks');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Tasks');

  String header = '';
  String description= '';
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Students');
    getTaskData();
  }
  void getTaskData() async {
    DataSnapshot snapshot = await reference.child(widget.taskKey).get();

    Map student = snapshot.value as Map;

    header = student['header'];
    print('the task is ${student['description']}');


    description = student['description'];


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, text: 'Task'),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: header,
                  fontSize: 18,
                  color: CustomColors.black.withOpacity(0.9),
                  isCenter: false,
                  textDecoration: TextDecoration.none),

              SizedBox(height: 10),

              CustomText(
                  text: description,
                  fontSize: 16,
                  color: CustomColors.black.withOpacity(0.6),
                  isCenter: false,
                  textDecoration: TextDecoration.none),
              const SizedBox(height: 30,),

               IconButton(
                icon:  const Icon(Icons.delete),
                highlightColor: Colors.red,

                onPressed: () async {
                   await reference.child(widget.taskKey).remove().then((value) =>                      Navigator.pop(context)
                   );

                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
      const CustomBottomNavBar(selectedMenu: MenuState.home),

    );
  }
}
