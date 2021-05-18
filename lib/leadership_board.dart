import 'package:flutter/material.dart';
import 'package:julius_project/main.dart';

class LeaderShipBoard extends StatelessWidget {
  static String id = 'leadership_board';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leadership'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close_rounded),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, HomePage.id, (route) => false),
          ),
        ],
      ),
    );
  }
}
