import 'package:flutter/material.dart';
import 'package:flutter_api_with_certificate/api/datahandler.dart';
import 'package:flutter_api_with_certificate/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String helloWorld = '';
  String token = '';
  Login login = Login(username: 'Mikkel', password: 'Mikkel123');

  DataHandler dh = DataHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(helloWorld),
            Text(token)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          token = await dh.postLogin(login);
          helloWorld = await dh.getHelloWorld(token);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
