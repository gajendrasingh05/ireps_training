import 'package:flutter/material.dart';
import 'bannedfirms.dart';

class Linkscreen extends StatefulWidget {
  const Linkscreen({super.key});

  @override
  _LinkscreenState createState() {
    return _LinkscreenState();
  }
}

class _LinkscreenState extends State<Linkscreen> {
  int _selectedIndex = 0;

  // list of bottom navigation bar
  final List<String> _labels = ["Home", "Login", "Helpdesk", "Links"];
  final List<IconData> _icons = [
    Icons.home,
    Icons.login_rounded,
    Icons.help,
    Icons.link,
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IREPS",
          style:
          TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        leading:
        Icon(Icons.menu_sharp,
            color: Colors.white),
      ),
      body:
      Column(
        children: [
          // Important links
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            padding: EdgeInsets.all(10.0),
            // space between text and box boundary
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.teal], // Gradient background
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.teal,
                  offset: Offset(0, 4),
                  blurRadius: 8.0,
                ),
              ],
            ),
            // icon of Important Links
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.link,
                  color: Colors.black,
                  size: 24.0,
                ),
                SizedBox(width: 8.0), //space between text and icon in row
                Text(
                  "Important Links",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // for 4 tabs
          SizedBox(height: 10.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // No. of columns
              mainAxisSpacing: 14.0, // Vertical space between grid items
              crossAxisSpacing: 14.0, // Horizontal space between grid items
              padding: EdgeInsets.all(20.0), // Padding around the grid
              children: [
                _buildGridTab(
                  context,
                  icon: Icons.insert_drive_file,
                  label: "e-Documents",
                  onTap: () {},
                ),

                _buildGridTab(
                  context,
                  icon: Icons.business,
                  label: "Banned Firms",
                  onTap: () {
                    // for working the tab
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BannedFirms()),
                    );
                  },
                ),

                _buildGridTab(
                  context,
                  icon: Icons.storage,
                  label: "AAC",
                  onTap: () {},
                ),

                _buildGridTab(
                  context,
                  icon: Icons.check_box,
                  label: "Approved Vendors",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),

      //function of bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          _icons.length,
              (index) => BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedIndex == index ? Colors.teal : Colors.grey[300],
              ),
              padding: EdgeInsets.all(10.0), // Add padding for the icon
              child: Icon(
                _icons[index],
                size: _selectedIndex == index ? 40.0 : 24.0, // Dynamic size
                color: _selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
            label: _labels[index], // Always display labels
          ),
        ),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true, // Show labels for unselected items as well
      ),
    );
  }

  Widget _buildGridTab(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey,
                  offset: Offset(0, 4),
                  blurRadius: 8.0
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.teal,
            ),

            SizedBox(height: 10),

            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}