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
        primaryColor: Colors.blue[800],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: IrepsHomePage(),
    );
  }
}

class IrepsHomePage extends StatefulWidget {
  @override
  _IrepsHomePageState createState() => _IrepsHomePageState();
}

class _IrepsHomePageState extends State<IrepsHomePage> {
  final List<String> workAreas = ['Goods and Services', 'Earning and Leasing', 'Works'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Main app bar color (darker blue)
    final Color mainNavColor = Colors.blue[800]!;
    // Secondary nav color (slightly lighter blue)
    final Color secondaryNavColor = Colors.blue[700]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainNavColor,
        elevation: 0,
        title: Text(
          'IREPS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        // White hamburger menu icon
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.blue[50]!],
              stops: [0.7, 1.0],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Enhanced header with gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue[900]!,
                      Colors.blue[700]!,
                    ],
                  ),
                ),
                padding: EdgeInsets.only(top: 50, bottom: 24, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: mainNavColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RISHI MEENA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'test.sse1@gmail.com',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified_user, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Railway User',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // User Home tile
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: _selectedIndex == 0 ? mainNavColor : Colors.grey[700],
                  ),
                  title: Text(
                    'User  Home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.w500,
                      color: _selectedIndex == 0 ? mainNavColor : Colors.grey[800],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),

              // Section divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.bar_chart, size: 18, color: Colors.blue[700]),
                    SizedBox(width: 8),
                    Text(
                      'REPORTS',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.blue[200],
                      ),
                    ),
                  ],
                ),
              ),

              // Reports tiles
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.bar_chart,
                    color: _selectedIndex == 1 ? mainNavColor : Colors.grey[700],
                  ),
                  title: Text(
                    'Stock Position Report',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                      color: _selectedIndex == 1 ? mainNavColor : Colors.grey[800],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),

              // Section divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 18, color: Colors.blue[700]),
                    SizedBox(width: 8),
                    Text(
                      'MY ACCOUNT',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.blue[200],
                      ),
                    ),
                  ],
                ),
              ),

              // Account tiles
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _selectedIndex == 3 ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: _selectedIndex == 3 ? mainNavColor : Colors.grey[700],
                  ),
                  title: Text(
                    'Change PIN',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: _selectedIndex == 3 ? FontWeight.bold : FontWeight.normal,
                      color: _selectedIndex == 3 ? mainNavColor : Colors.grey[800],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),

              // Divider before logout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Divider(color: Colors.blue[200], thickness: 0.5),
              ),

              // Logout button
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red[700],
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.red[700],
                    ),
                  ),
                  onTap: () {
                    // Handle logout
                    Navigator.pop(context);
                  },
                ),
              ),

              SizedBox(height: 40),

              // App version at bottom
              Center(
                child: Text(
                  'IREPS v2.0.1',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Secondary navbar with login info
          Container(
            color: secondaryNavColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Successful Login',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '18/03/25 12:11:25',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    // Handle work area selection
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected: $result')),
                    );
                  },
                  itemBuilder: (BuildContext context) => workAreas
                      .map((String choice) => PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
                      .toList(),
                  color: Colors.white, // Set the background color of the options box to white
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Solid white background for the dropdown
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Work Area',
                            style: TextStyle(
                              color: secondaryNavColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_drop_down,
                            color: secondaryNavColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'My Reports',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        ReportCard(
                          title: "Stock Position",
                          icon: Icons.bar_chart,
                          color: Colors.green,
                          iconSize: 28,
                        ),
                        // Empty container for spacing
                        Container(),
                      ],
                    ),
                  ),
                  // Bottom alert box
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue[700],
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'You may also change Work Area from top right corner.',
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final double iconSize;

  const ReportCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    this.iconSize = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: iconSize,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}