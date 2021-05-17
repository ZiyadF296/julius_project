import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:julius_project/components/main_button.dart';
import 'package:julius_project/leadership_board.dart';
import 'package:julius_project/main.dart';
import 'package:julius_project/models/question_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayGame extends StatefulWidget {
  static String id = 'play_game';

  final bool valid;

  PlayGame({this.valid = false});

  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  // Utils
  late SharedPreferences _pref;
  bool _loadingForm = true;
  String? _name;

  Future<void> _loadUser() async {
    if (!widget.valid) {
      Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
    } else {
      _pref = await SharedPreferences.getInstance();
      if (_pref.containsKey('user_nickname')) {
        setState(() {
          _name = _pref.getString('user_nickname');
          if (_pref.containsKey('question_index')) {
            // Questions limit exceeded
            if (myquestions.length < _pref.getInt('question_index')!) {
              _questionIndex = 0;
            }
            // Questions not exceed - set default
            else {
              _questionIndex = _pref.getInt('question_index')!;
            }
          }
        });
        DocumentSnapshot<dynamic> _result = await FirebaseFirestore.instance
            .collection('users')
            .doc(_pref.getString('user_nickname'))
            .get();
        if (_result.exists) {
          setState(() => _loadingForm = false);
        } else {
          _pref.clear();
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.id, (route) => false);
          showDialog(
            context: context,
            builder: (_) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    Text(
                      'Looks like there already is a user with that name! Try again with another one.',
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      onPressed: () => Navigator.pop(context),
                      width: 100,
                      text: 'OK',
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      } else {
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    }
  }

  int _questionIndex = 0;
  bool _loading = false;

  Future<void> _nextQuestion() async {
    if (_questionIndex >= myquestions.length) {
      await _pref.setBool('completed_game', true);
      await _pref.setInt('question_index', 0);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_name)
          .update({'completed_game': true});
      Navigator.pushReplacementNamed(context, LeaderShipBoard.id);
    } else {
      setState(() => _loading = true);
      _pref = await SharedPreferences.getInstance();
      await _pref.setInt('question_index', _questionIndex + 1);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_name)
          .update({'current_question': _questionIndex + 1});
      setState(() {
        _questionIndex++;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  void dispose() {
    _loadingForm = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loadingForm
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        MainButton(
                          loading: _loading,
                          onPressed: _nextQuestion,
                          text: 'Next',
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(_name)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Score: ' +
                                      snapshot.data!.data()['score'].toString(),
                                ),
                              ),
                              Text(snapshot.data!.data()['name']),
                            ],
                          ),
                        );
                      } else {
                        return LinearProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
