import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import '../utilities/sizes.dart';
import 'custome_widget/app_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(

        appBar: CustomAppBar(context: context, text:'Login'),
    );
  }
}

