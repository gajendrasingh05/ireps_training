import 'package:flutter/material.dart';

class BannedFirms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banned Firms",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          "This is the Banned Firms page.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
