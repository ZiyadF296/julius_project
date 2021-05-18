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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Instructions: \n\nThere will be a number of questions you will have to get through to reach the end goal. \nEach question is individually valued ranging from 150 to 3,000 points. \nIf you answer one question wrong, you lose half of what the question was originally valued at, meaning it is possible to have negative points. \n\nThe player with the most points at the end wins.',
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
