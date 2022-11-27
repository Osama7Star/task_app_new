import 'package:flutter/material.dart';

import '../../utilities/colors.dart';
import '../../utilities/sizes.dart';

CustomAppBar(
    {required BuildContext context,
      required String text,
      String? text2,
      Color? color,
      double? fontSize,
    }) =>
    AppBar(
      centerTitle: true,
      backgroundColor: CustomColors.white,
      title: RichText(
          text: TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: text,
                  style: TextStyle(
                      color: CustomColors.black,
                      fontSize: CustomSizes.header3,
                      fontFamily: 'Schyler')),
              TextSpan(
                  text: text2??'',
                  style: TextStyle(
                      color: CustomColors.white,
                      fontSize: CustomSizes.header3,
                      fontFamily: 'Schyler'))
              ,
            ],
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CircleAvatar(
            radius: 15, // Image radius
            backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png'),
          ),
        )
      ],
    );