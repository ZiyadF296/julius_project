import 'package:flutter/material.dart';

class LearnHowToPlay extends StatelessWidget {
  static String id = 'learn_how_to_play';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn To Play'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
