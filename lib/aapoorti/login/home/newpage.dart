import 'package:flutter/material.dart';

class Newpage extends StatefulWidget {
  const Newpage({super.key});

  @override
  State<Newpage> createState() => _NewpageState();
}

class _NewpageState extends State<Newpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello World!!!"),
      ),
    );
  }
}
