import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePageApp());
}

class ProfilePageApp extends StatefulWidget {
  @override
  _ProfilePageAppState createState() => _ProfilePageAppState();
}

class _ProfilePageAppState extends State<ProfilePageApp> {
  int _selectedIndex = 1; // Default to Profile tab

  final List<Widget> _pages = [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 20))),
    ProfilePage(),
    Center(child: Text('Settings Page', style: TextStyle(fontSize: 20))),
    Center(child: Text('Helpdesk Page', style: TextStyle(fontSize: 20))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          backgroundColor: Colors.teal,
          title: Text("Profile", style: TextStyle(color: Colors.white)),
          elevation: 4,
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(opacity: animation, child: child),
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Helpdesk'),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userName = "CRIS TEST 2022";
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.teal.shade400,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              "User Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 15),
            _buildDetailsContainer([
              _buildDetailRow(Icons.phone, Colors.green, "919999991111"),
              _buildDetailRow(Icons.email, Colors.red, "test.sse1@gmail.com"),
              _buildDetailRow(Icons.account_circle, Colors.blue, "Railway User"),
              _buildDetailRow(Icons.lock, Colors.orange, "MM"),
              _buildDetailRow(Icons.apartment, Colors.purple, "IREPS-TESTING"),
            ]),
            SizedBox(height: 40),
            _buildDetailsContainer([
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.teal, size: 24),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Last Login Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("16/01/25 13:21:33", style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                    ],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsContainer(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 3, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: children
            .map((child) => Column(children: [child, Divider(height: 20, thickness: 1.5)]))
            .expand((widget) => widget.children)
            .toList()
          ..removeLast(),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 12),
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
