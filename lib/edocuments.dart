import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue[800],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      home: EDocumentsPage(),
    );
  }
}

class EDocumentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Documents'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Learning Centre'),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                buildCardTile('General', Icons.article, Colors.deepOrangeAccent, true),
                buildCardTile('E-Tender\n(Goods&Services)', Icons.shopping_bag, Colors.teal, false),
                buildCardTile('E-Tender\n(Works)', Icons.construction, Colors.amber, false),
                buildCardTile('E-Tender\n(Earning/Leasing)', Icons.attach_money, Colors.pink, false),
                buildCardTile('E-Auction', Icons.gavel, Colors.red, false),
                buildCardTile('iMMS', Icons.inventory, Colors.blueGrey, false),
                buildCardTile('FAQ', Icons.help_outline, Colors.cyan, false),
                buildCardTile('System\nSettings', Icons.settings, Colors.brown, false),
              ],
            ),
            SizedBox(height: 30),
            SectionHeader(title: 'Public Documents'),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                buildCardTile('Goods &\nServices', Icons.local_shipping, Colors.green, false),
                buildCardTile('Auction', Icons.balance, Colors.deepPurpleAccent, false),
                buildCardTile('Works', Icons.build, Colors.indigo, false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardTile(String label, IconData icon, Color color, bool isSmaller) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmaller ? 8 : 10),
        boxShadow: isSmaller
            ? []
            : [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(isSmaller ? 8 : 10),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 40,
            ),
            SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 25,
          color: Colors.lightBlue[800],
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue[800],
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }
}
