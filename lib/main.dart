import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'عرض الصورة',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('عرض any.png'),
          centerTitle: true,
        ),
        body: Center(
          child: Image.asset(
            'assets/any.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
