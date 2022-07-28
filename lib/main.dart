import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final List<dynamic> deviceList = [""];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Click on FloatingActionButton and get Documents using MethodChannel.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'You have ${widget.deviceList.length} files in your download folder ',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getDocuments,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _getDocuments() async {
    List<dynamic> documentList = [""];
    MethodChannel _methodChannel = MethodChannel('flutter/accessFiles');
    try {
      documentList = await _methodChannel.invokeMethod("Documents");
    } on PlatformException catch (e) {
      print("exceptiong");
    }
    documentList.forEach((document) {
      setState(() {
        widget.deviceList.add(document);
      });
      print("Document: $document");

    });
  }
}