import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
import 'models/IssueFactorValues.dart';
import './amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_datastore/amplify_datastore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // final _amplify = Amplify;

  @override
  void initState() {
    _initializeApp();
    super.initState();
  }

  Future<void> _initializeApp() async {
    // configure Amplify
    await _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      // amplify plugins
      final _dataStorePlugin =
          AmplifyDataStore(modelProvider: ModelProvider.instance);

      // add Amplify plugins
      await Amplify.addPlugins([_dataStorePlugin]);

      // configure Amplify
      //
      // note that Amplify cannot be configured more than once!
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      safePrint('An error occurred while configuring Amplify: $e');
    }
  }

  void _incrementCounter() {
    print(Amplify.isConfigured);
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Local
Future<void> readFromDatabase() async {
  try {
    final posts = await Amplify.DataStore.query(IssueFactorValues.classType);
    print('Posts: $posts');
  } on DataStoreException catch (e) {
    print('Query failed: $e');
  }
}
