import 'package:engage_parse_admin/classes/project.dart';
import 'package:engage_parse_admin/engage.dart';
import 'package:engage_parse_admin/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

// const String PARSE_APP_ID = '';
// const String PARSE_APP_URL = '';
// const String MASTER_KEY = '';
// const String CLIENT_KEY = '';
// const String LIVE_QUERY_URL = '';

const String PARSE_APP_ID = 'LkmOVjo3u8bdEyXCkIBKY4kDOs1q6tiQLzUXXZTZ';
const String PARSE_APP_URL = 'https://parseapi.back4app.com';
const String MASTER_KEY = 'ZHH5Ez7W8qtYsdG3y6fS2ltInSD28cgxH3E4m9By';
const String CLIENT_KEY = 'WU3oevS75xMv7dGcr8rghkWoci33GaP8lGZgNbbc';
const String LIVE_QUERY_URL = 'wss://trongdth.back4app.io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    PARSE_APP_ID,
    PARSE_APP_URL,
    masterKey: MASTER_KEY,
    liveQueryUrl: LIVE_QUERY_URL,
    autoSendSessionId: true,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );
  ParseUser user = await ParseUser.currentUser();
  runApp(MyApp(user));
}

class MyApp extends StatelessWidget {
  final user;
  MyApp(
    this.user,
  );
  @override
  Widget build(BuildContext context) {
    return Engage.init(
        user: user, project: EngageProject(), collections: [Game()]);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
