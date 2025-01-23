import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'About Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20), // Added space below the navbar
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/logo.png'),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'IREPS\nIndian Railways E-Procurement System',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'This is the official mobile app of IREPS application (www.ireps.gov.in). IREPS mobile app provides information available on IREPS. IREPS application provides services related to procurement of Goods, Works and Services, Sale of Materials through the process of E-Tendering, E-Auction or Reverse Auction.',
                        style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    leading: Icon(Icons.info_outline, color: Colors.blue.shade800),
                    title: Text('App Name & Version'),
                    subtitle: Text('IREPS : v8.01.06(1811)'),
                  ),
                  Divider(indent: 8, endIndent: 8),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    leading: Icon(Icons.language, color: Colors.blue.shade800),
                    title: Text('Website'),
                    subtitle: Text('www.ireps.gov.in'),
                    onTap: () {
                      // Add link opening logic
                    },
                  ),
                  Divider(indent: 8, endIndent: 8),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    leading: Icon(Icons.privacy_tip, color: Colors.blue.shade800),
                    title: Text('Privacy Policy'),
                    onTap: () {
                      // Add privacy policy logic
                    },
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Developed and Published by',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Centre for Railway Information Systems',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '(An Organization of the Ministry of Railways, Govt. of India)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 20, color: Colors.blue.shade800),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutUsPage(),
    debugShowCheckedModeBanner: false,
  ));
}
