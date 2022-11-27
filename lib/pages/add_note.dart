import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../utilities/colors.dart';
import '../utilities/sizes.dart';
import 'custome_widget/app_bar.dart';
import 'custome_widget/bottom_bar.dart';
import 'custome_widget/input_field.dart';
import 'custome_widget/text.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late DatabaseReference dbRef;
  final _formKey = GlobalKey<FormState>();
  final myControllerHeader = TextEditingController();
  final myControllerDescription = TextEditingController();
  NoteModel? noteModel;

  @override
  initState() {
    super.initState();

    dbRef = FirebaseDatabase.instance.ref().child("Tasks");
  }

  @override
  Widget build(BuildContext context) {
    // dbRef = FirebaseDatabase.instance.ref().child("Tasks");

    return Scaffold(
      appBar: CustomAppBar(context: context, text: 'Tasks'),

      body: ListView(
        children: [

          const SizedBox(height: 20),
          const CustomText(
              text: 'Add Tasks',
              color: CustomColors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,

          ),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InputField(
                        controller: myControllerHeader,
                        hintText: 'Enter note header',
                        labelText: 'header',




                        prefixIcon: IconButton(
                          icon: Icon(Icons.note),
                          onPressed: () {},
                        ),
                        verticalPadding: 10),

                    const SizedBox(height: 30),
                    InputField(
                        hintText: "Enter note description",
                        labelText: 'Description',
                        controller: myControllerDescription,
                        verticalPadding: 70,
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.note_alt_outlined),
                        onPressed: () {},
                      ),),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(Icons.sort,
                                  size: 30, color: CustomColors.blue),
                              Icon(Icons.date_range_rounded,
                                  size: 30, color: CustomColors.blue),
                              Icon(Icons.star_border_outlined,
                                  size: 30, color: CustomColors.blue)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("Testing");
                                  DateTime now = new DateTime.now();
                                  DateTime date = new DateTime(
                                      now.year,
                                      now.month,
                                      now.day,
                                      now.hour,
                                      now.minute,
                                      now.second);
                                  String date1 = date.toString();

                                  Map<dynamic, String> task = {
                                    'header': myControllerHeader.text,
                                    'description': myControllerDescription.text,
                                    'isFinished': '0',
                                    'isFavorite': '0',
                                    'date': date1
                                  };
                                  dbRef
                                      .push()
                                      .set(task)
                                      .then((value) => Navigator.pop(context));

                                  print("Testing");
                                },
                                child: const CustomText(
                                    text: 'Save',
                                    fontSize: 20,
                                    color: CustomColors.blue,
                                    isCenter: false),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
