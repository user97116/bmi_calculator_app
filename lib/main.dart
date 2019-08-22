import './ui/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(Welcome());

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome App",
			home: Home(),
			debugShowCheckedModeBanner: false,
    );
  }
}

