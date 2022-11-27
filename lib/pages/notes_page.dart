import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import '../utilities/sizes.dart';
import 'add_note.dart';
import 'all_note_page.dart';
import 'custome_widget/app_bar.dart';
import 'custome_widget/bottom_bar.dart';
import 'custome_widget/text.dart';
import 'favourite_task.dart';
import 'note_details.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int finishedNoteNumber = 0;

    SizeConfig().init(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(context: context, text: 'Tasks'),
        body: ListView(
          children: [
            SizedBox(
              height: CustomSizes.height7,
              child: Card(
                margin: EdgeInsets.zero,
                child: TabBar(
                  tabs: [
                    Tab(
                        child: CustomText(
                            text: 'All Tasks',
                            color: CustomColors.black,
                            fontSize: CustomSizes.header5,
                            fontWeight: FontWeight.bold)),
                    Tab(
                        child: CustomText(
                            text: 'Favorite Tasks',
                            color: CustomColors.black,
                            fontSize: CustomSizes.header5,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: 100,
                height: 3000,
                child: TabBarView(
                  children: [
                    ///TODO :USER USERID
                    const AllNotePage(),

                    FavouriteTask(),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            const CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}

class NoteWidget extends StatefulWidget {
  NoteWidget({Key? key, required this.task})
      : super(
          key: key,
        );

  @override
  State<NoteWidget> createState() => _NoteWidgetState();

  Map task;
}

class _NoteWidgetState extends State<NoteWidget> {
  bool isChecked = false;
  late DatabaseReference dbRef;

  @override
  initState() {
    super.initState();

    dbRef = FirebaseDatabase.instance.ref().child("Tasks");
  }

  @override
  Widget build(BuildContext context) {
    //int mapSize = widget.task.length;

    IconData iconData = Icons.favorite_border;
    return widget.task['isFinished'] == "0"
        ? InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          NoteDetails(taskKey: widget.task['key'])));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Checkbox(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      value: isChecked,
                      onChanged: (v) {
                        setState(() {
                          isChecked = v!;
                          //  print('Student key is${widget.task['key']}');
                          Map<String, String> task = {
                            'header': widget.task['header'],
                            'description': widget.task['description'],
                            'isFinished': "1"
                          };
                          dbRef.child(widget.task['key']).update(task);
                        });
                      },
                    )),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: widget.task['header'],
                          fontSize: 18,
                          color: CustomColors.black.withOpacity(0.9),
                          isCenter: false,
                          textDecoration: TextDecoration.none),
                      SizedBox(height: 10),
                      CustomText(
                          text: widget.task['description'],
                          fontSize: 16,
                          color: CustomColors.black.withOpacity(0.6),
                          isCenter: false,
                          textDecoration: TextDecoration.none),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(widget.task['isFavorite'] == "0"
                        ? Icons.favorite_border
                        : Icons.favorite),
                    highlightColor: Colors.red,
                    onPressed: () async {
                   String   isFavorite = widget.task['isFavorite'];

                      if (widget.task['isFavorite'] == "0"){
                        isFavorite = "1";

                      }
                      else{
                        isFavorite = "0";
                      }
                      Map<String, String> task = {
                        'header': widget.task['header'],
                        'description': widget.task['description'],
                        'isFinished': "0",
                        'isFavorite': isFavorite,
                      };
                      dbRef.child(widget.task['key']).update(task);
                    },
                  ),
                )
              ],
            ),
          )
        : SizedBox();
    // : Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Image.asset(
    //         'lib/assets/images/no_notes.png',
    //       ),
    //       SizedBox(height: 50),
    //       CustomText(text: 'No task yet', fontSize: 30),
    //       SizedBox(height: 20),
    //       CustomText(
    //           text:
    //               'Add your to-dos and keep track of them /n across Google Workspace',
    //           fontSize: 15,
    //           color: CustomColors.grey),
    //     ],
    //   );
  }
}

class FinishedNote extends StatelessWidget {
  FinishedNote({Key? key, required this.task}) : super(key: key);
  Map task;

  @override
  Widget build(BuildContext context) {
    print('teeeeeee ${task['header']}');
    return task['isFinished'] != "0"
        ? Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: task['header'],
                      fontSize: 18,
                      color: CustomColors.black.withOpacity(0.7),
                      isCenter: false,
                      textDecoration: TextDecoration.lineThrough,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          )
        : SizedBox();
  }
}
