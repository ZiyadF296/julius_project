import 'package:flutter/material.dart';
import 'package:julius_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:julius_project/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderShipBoard extends StatefulWidget {
  static String id = 'leadership_board';

  @override
  _LeaderShipBoardState createState() => _LeaderShipBoardState();
}

bool _formLoading = true;
late SharedPreferences _pref;
late String _name;

List<Widget> _finalResults = [];

class _LeaderShipBoardState extends State<LeaderShipBoard> {
  Future<void> _initLeaderShipBoard() async {
    _pref = await SharedPreferences.getInstance();
    // Checks if there is a user
    if (_pref.containsKey('completed_game') &&
        _pref.getBool('completed_game') == true &&
        _pref.containsKey('user_nickname')) {
      setState(() => _name = _pref.getString('user_nickname')!);
      // Loads the leadership board from greatest
      // to least points.
      QuerySnapshot<dynamic>? _result = await FirebaseFirestore.instance
          .collection('users')
          .where('completed_game', isEqualTo: true)
          .orderBy('score', descending: true)
          .limit(25)
          .get();
      for (var i = 0; _result.docs.length > i; i++) {
        _finalResults.add(
          i == 0
              // First Place
              ? _topBoardWidget(
                  LeaderPosition.first,
                  _result.docs[i].data()['name'],
                  _result.docs[i].data()['answers'] as List,
                  i,
                  _name == _result.docs[i].data()['name'],
                )
              : i == 1
                  // Second Place
                  ? _topBoardWidget(
                      LeaderPosition.second,
                      _result.docs[i].data()['name'],
                      _result.docs[i].data()['answers'] as List,
                      i,
                      _name == _result.docs[i].data()['name'],
                    )
                  : i == 2
                      // Thid Place
                      ? _topBoardWidget(
                          LeaderPosition.third,
                          _result.docs[i].data()['name'],
                          _result.docs[i].data()['answers'] as List,
                          i,
                          _name == _result.docs[i].data()['name'],
                        )
                      // Other Place
                      : _topBoardWidget(
                          LeaderPosition.other,
                          _result.docs[i].data()['name'],
                          _result.docs[i].data()['answers'] as List,
                          i,
                          _name == _result.docs[i].data()['name'],
                        ),
        );
      }
      setState(() => _formLoading = false);
    } else {
      // User didn't play game or session period
      // has ended.
      await Future.delayed(const Duration(milliseconds: 200));
      await Navigator.pushNamedAndRemoveUntil(
          context, HomePage.id, (route) => false);
    }
  }

  @override
  void initState() {
    _initLeaderShipBoard();
    super.initState();
  }

  @override
  void dispose() {
    _finalResults = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leadership Board'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, HomePage.id, (route) => false),
          ),
        ],
      ),
      body: _formLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 3))
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 600,
                  child: ListView.builder(
                    itemCount: _finalResults.length,
                    itemBuilder: (_, i) {
                      return _finalResults[i];
                    },
                  ),
                ),
              ),
            ),
    );
  }
}

Widget _topBoardWidget(LeaderPosition position, String name, List totalCorrect,
    int index, bool isMe) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    decoration: BoxDecoration(
      color: Colors.brown[700],
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 80,
    child: Row(
      children: [
        if (position == LeaderPosition.first)
          Image.asset('assets/icons/first.png', height: 40),
        if (position == LeaderPosition.second)
          Image.asset('assets/icons/second.png', height: 40),
        if (position == LeaderPosition.third)
          Image.asset('assets/icons/third.png', height: 40),
        if (position == LeaderPosition.other)
          SizedBox(
            width: 40,
            child: Center(
                child: Text((index + 1).toString(),
                    style: const TextStyle(fontSize: 40))),
          ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text(
                '${totalCorrect.where((e) => e == true).length} / ${myquestions.length} Correct',
                style: TextStyle(color: Colors.brown[100]),
              ),
            ],
          ),
        ),
        if (isMe)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Tooltip(
              message: 'This is me!',
              child: Icon(Icons.star, color: Colors.yellowAccent),
            ),
          ),
        if (position != LeaderPosition.other)
          Text((index + 1).toString(), style: const TextStyle(fontSize: 40)),
      ],
    ),
  );
}

enum LeaderPosition { first, second, third, other }
