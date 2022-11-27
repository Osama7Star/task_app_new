import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import 'custome_widget/text.dart';
class NoTask extends StatelessWidget {
  const NoTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Image.asset(
                'lib/assets/images/no_notes.png',

              ),
              SizedBox(height: 50),

              CustomText(text: 'No task yet',fontSize: 30),
              SizedBox(height: 20),
              CustomText(text: 'Add your to-dos and keep track of them /n across Google Workspace',fontSize: 15,color: CustomColors.grey),

            ],
          )
        ],
      ),
    );
  }
}
