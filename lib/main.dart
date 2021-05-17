import 'package:flutter/material.dart';
import 'package:julius_project/components/main_button.dart';
import 'package:julius_project/get_started.dart';
import 'package:julius_project/leadership_board.dart';
import 'package:julius_project/learn_how_to_play.dart';
import 'package:julius_project/play_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _pref;

String? _name;

Future<void> main() async {
  _pref = await SharedPreferences.getInstance();
  if (_pref.containsKey('user_nickname')) {
    _name = 'Hello, ${_pref.getString('user_nickname')}';
  }
  runApp(JuliusMain());
}

class JuliusMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _name ?? 'Julius Caesar',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.brown[800],
        appBarTheme: AppBarTheme(color: Colors.brown),
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        LearnHowToPlay.id: (context) => LearnHowToPlay(),
        GetStarted.id: (context) => GetStarted(),
        PlayGame.id: (context) => PlayGame(),
        LeaderShipBoard.id: (context) => LeaderShipBoard(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  static String id = 'welcome';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/welcome_bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.srgbToLinearGamma(),
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xff4A3126),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Tooltip(
                //   message: 'Clear cache',
                //   child: FlatButton(
                //     onPressed: () async {
                //       late SharedPreferences _pref;
                //       _pref = await SharedPreferences.getInstance();
                //       _pref.clear();
                //     },
                //     child: Icon(Icons.close),
                //   ),
                // ),
                Text('Title of Game', style: TextStyle(fontSize: 25)),
                const SizedBox(height: 15),
                Image.asset('image/julius_cartoon.png', height: 200),
                const SizedBox(height: 15),
                MainButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LearnHowToPlay.id);
                  },
                  text: 'Learn How To Play',
                ),
                const SizedBox(height: 15),
                MainButton(
                  onPressed: () {
                    Navigator.pushNamed(context, GetStarted.id);
                  },
                  text: 'Get Started',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}