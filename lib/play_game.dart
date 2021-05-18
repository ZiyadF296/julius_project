import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<bool> _answerStatus = [];

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
          if (_pref.getInt('question_index') == 0) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(_name)
                .update({'score': 0});
          }
        });
        DocumentSnapshot<dynamic> _result = await FirebaseFirestore.instance
            .collection('users')
            .doc(_pref.getString('user_nickname'))
            .get();
        if (_result.exists) {
          try {
            DocumentSnapshot<dynamic> _answerResult = await FirebaseFirestore
                .instance
                .collection('users')
                .doc(_name)
                .get();
            _answerStatus.clear();
            // print(_answerResult);
            List<dynamic>? _finalAnswers =
                _answerResult.data()['answers'] as List<dynamic>;
            for (var i = 0; _finalAnswers.length > i; i++) {
              _answerStatus.add(_finalAnswers[i]);
            }
          } catch (_) {}
          setState(() => _loadingForm = false);
        } else {
          _pref.clear();
          showDialog(
            context: context,
            builder: (_) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Nope!', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    Text(
                      'Looks like there already is a user with that name! Try again with another one.',
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, HomePage.id, (route) => false),
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

  Future<void> _nextQuestion(bool isCorrect, double points) async {
    if (_questionIndex + 1 >= myquestions.length) {
      await _pref.setBool('completed_game', true);
      await _pref.setInt('question_index', 0);
      if (isCorrect) {
        FirebaseFirestore.instance.collection('users').doc(_name).update({
          'score': FieldValue.increment(points),
        });
      } else {
        FirebaseFirestore.instance.collection('users').doc(_name).update({
          'score': FieldValue.increment(-points),
        });
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_name)
          .update({'completed_game': true});
      Navigator.pushReplacementNamed(context, LeaderShipBoard.id);
    } else {
      setState(() => _loading = true);
      _pref = await SharedPreferences.getInstance();
      await _pref.setInt('question_index', _questionIndex + 1);
      if (isCorrect) {
        _answerStatus.add(true);
        FirebaseFirestore.instance.collection('users').doc(_name).update({
          'score': FieldValue.increment(points),
          'answers': _answerStatus,
        });
      } else {
        _answerStatus.add(false);
        FirebaseFirestore.instance.collection('users').doc(_name).update({
          'score': FieldValue.increment(-points),
          'answers': _answerStatus,
        });
      }
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
                  const SizedBox(height: 15),
                  Text('${_questionIndex + 1} / ${myquestions.length}'),
                  // Form
                  _loading
                      ? Expanded(
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                myquestions[_questionIndex].title,
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              if (myquestions[_questionIndex].description != '')
                                Text(
                                  myquestions[_questionIndex].description,
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 600,
                                child: Center(
                                  child: Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: myquestions[_questionIndex]
                                        .options
                                        .map(
                                          (e) => _formOptionButtons(() {
                                            if (e ==
                                                myquestions[_questionIndex]
                                                    .answer) {
                                              // Answered Correctly
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  backgroundColor: Colors.brown,
                                                  content: Row(
                                                    children: [
                                                      Icon(Icons.check,
                                                          color: Colors.green),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'Yup! That\'s right!',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              _nextQuestion(
                                                  true,
                                                  myquestions[_questionIndex]
                                                      .value);
                                            } else {
                                              // False answer
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  backgroundColor: Colors.brown,
                                                  content: Row(
                                                    children: [
                                                      Icon(Icons.close,
                                                          color: Colors.red),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'Nope! That was the wrong answer!',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              _nextQuestion(
                                                false,
                                                myquestions[_questionIndex]
                                                        .value
                                                        .toDouble() /
                                                    2,
                                              );
                                            }
                                          }, e),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _answerStatus.map((e) {
                        if (e) {
                          return Tooltip(
                              message: 'Correct',
                              child: Icon(Icons.check, color: Colors.green));
                        } else {
                          return Tooltip(
                              message: 'Wrong',
                              child: Icon(Icons.close, color: Colors.red));
                        }
                      }).toList(),
                    ),
                  ),
                  // Bottom Footer User Status
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

Widget _formOptionButtons(Function onPressed, String message) {
  return MaterialButton(
    height: 50,
    minWidth: 200,
    elevation: 0,
    focusElevation: 0,
    hoverElevation: 0,
    disabledElevation: 0,
    highlightElevation: 0,
    onPressed: onPressed as Function(),
    focusColor: Colors.black26,
    hoverColor: Colors.black26,
    splashColor: Colors.black26,
    highlightColor: Colors.black26,
    color: Colors.black26,
    child: Text(
      message,
      textAlign: TextAlign.center,
    ),
  );
}
