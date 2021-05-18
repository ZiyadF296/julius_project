import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:julius_project/components/main_button.dart';
import 'package:julius_project/main.dart';
import 'package:julius_project/play_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatefulWidget {
  static String id = 'get_started';

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  // Keys
  final GlobalKey<FormState> _getStartedFormKey = GlobalKey();

  // Utils
  bool _loadingForm = true;
  bool _loading = false;
  late SharedPreferences _pref;

  // Inputs
  String? _name;

  Future<void> _validateSession() async {
    _pref = await SharedPreferences.getInstance();
    // Checks if there has been a user before. If yes
    // then it will check whether this user has completed
    // the game or not.
    if (_pref.containsKey('completed_game')) {
      _pref.clear();
      setState(() => _loadingForm = false);
      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome Back!', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Text(
                  'Great to have you here again! Let\'s play again!',
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
    } else if (_pref.containsKey('user_nickname')) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => PlayGame(valid: true)));
    } else {
      setState(() => _loadingForm = false);
    }
  }

  Future<void> _createUser() async {
    // Tries to create a user. If the user is created, then
    // it will start the game and take the user to the play
    // page. Else it will show an error.
    try {
      await _pref.setString('user_nickname', _name!);
      await FirebaseFirestore.instance.collection('users').doc(_name!).set({
        'name': _name,
        'last_session': DateTime.now().toString(),
        'score': 0,
      });
      setState(() => _loading = false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => PlayGame(valid: true)));
    }
    // In the case it fails to add the user, it will show a
    // failed dialog informing about the failure and telling
    // to retry.
    catch (_) {
      setState(() => _loading = false);
      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Couldn\'t Add You!', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Text(
                  'For some reason, we couldn\'t add you as a user. How about trying again later?',
                ),
                const SizedBox(height: 20),
                MainButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomePage.id, (route) => false);
                  },
                  width: 100,
                  text: 'OK',
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> _loadUserUpdate() async {
    _pref = await SharedPreferences.getInstance();
    // Makes sure not random age is entered
    if (_getStartedFormKey.currentState!.validate()) {
      setState(() => _loading = true);
      DocumentSnapshot<dynamic> _result = await FirebaseFirestore.instance
          .collection('users')
          .doc(_name!)
          .get();
      // Checks if the user alreay exists and completed
      // the game. If yes, then deleted the user and
      // assigns current user the name. Else will inform
      // that already exsits.
      if (_result.exists &&
          _result.data()['completed_game'] != null &&
          _result.data()['completed_game'] == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_name)
            .delete();
        await _createUser();
      }
      // Checks if the date that last user passed is 1 day, if yes, deletes
      // it and gives it to the current user.
      // Else, will say user already exist. Session updates when user visits
      // play game page.
      else if (_result.exists &&
          DateTime.parse(_result.data()!['last_session'])
                  .difference(DateTime.now()) <
              const Duration(days: 1)) {
        setState(() => _loading = false);
        await showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Well...', style: TextStyle(fontSize: 20)),
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
      // If the user already exists, then it will say
      // that there is already a user with that name
      // that is playing this game, so choose another
      // name.
      else if (_result.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_name!)
            .delete();
        await _createUser();
      }
      // The user doesn't exist so it will now assign
      // current user this name and let them start
      // playing the game.
      else {
        // Tries to create the user
        await _createUser();
      }
    }
  }

  @override
  void initState() {
    // Validates and makes sure that this
    // is a new user and not a user that
    // is going to continue to play the game
    _validateSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Started'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: _loadingForm
            // Shows a load page if the form is still loading
            // the user data. Typically would take long if the
            // device is slow to perform local read/write actions.
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: 300,
                  child: Form(
                    key: _getStartedFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Let\'s Play!', style: TextStyle(fontSize: 25)),
                        const SizedBox(height: 20),
                        // Asks the user for their name that they want
                        // to be called. Name can't be less than 3 characters
                        // and not more than 25 characters.
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Nickname'),
                          onChanged: (val) => _name = val,
                          validator: (val) => val == null
                              ? 'Please enter your nickname'
                              : val.length < 3
                                  ? 'Nickname needs to be more than 2 characters.'
                                  : val.length > 25
                                      ? 'Nickname is too long, should be shorter.'
                                      : null,
                        ),
                        const SizedBox(height: 25),
                        // Submit button
                        MainButton(
                          loading: _loading,
                          onPressed: _loadUserUpdate,
                          text: 'Let\'s Go',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
