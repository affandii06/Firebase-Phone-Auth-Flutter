import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phoneauth_firebase/phone_number.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phoneauth Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Phoneauth Firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<Timer> startimer()async{
    return Timer(Duration(seconds: 2), onDone);
  }

  onDone(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Phonenumber()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
