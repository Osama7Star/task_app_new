import 'package:flutter/material.dart';

import '../../utilities/colors.dart';
import '../../utilities/sizes.dart';
import '../add_note.dart';
import '../all_note_page.dart';
import 'IconInContainer.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: CustomSizes.padding3),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -45),
                    blurRadius: 90,
                    color: CustomColors.primary.withOpacity(0.15),
                  ),
                ],
              ),
              child: SafeArea(
                  top: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex:2,
                        child: Container(
                          decoration:  const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:CustomColors.white,
                                width: 3,
                              ),

                            ),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.menu_outlined,
                                size: 20),
                            highlightColor: CustomColors.primary,

                            onPressed: () {

                            },
                          ),
                        ),
                      ),

                      Expanded(
                        flex:2,
                        child: Container(
                          decoration:  BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:CustomColors.white,
                                width: 3,
                              ),

                            ),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.more_horiz,
                                size: 20),
                            highlightColor: CustomColors.primary,

                            onPressed: () {

                            },
                          ),
                        ),
                      ),


                    ],
                  )),
            ),
          ),
        ),
         Positioned(bottom:10,child: GestureDetector(onTap: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNote()));

         }, child: IconInContainer(icon: Icons.add, radius: 50,iconSize: CustomSizes.iconSize*1.2,padding: 16,borderColor: CustomColors.white,))),
      ],
    );
  }
}

enum MenuState { home, search,profile,promotion }
