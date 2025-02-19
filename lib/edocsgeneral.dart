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
        primaryColor: Colors.lightBlue[700],
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue[700],
          elevation: 3,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      home: GeneralSectionPage(),
    );
  }
}

class GeneralSectionPage extends StatefulWidget {
  @override
  _GeneralSectionPageState createState() => _GeneralSectionPageState();
}

class _GeneralSectionPageState extends State<GeneralSectionPage> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Home button pressed',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.lightBlue[700],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: generalItems.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = generalItems[index];
            return buildListItem(context, item['title'] ?? '', index);
          },
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(20),
              content: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Choose an option for file  ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '"$title"',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          color: Colors.lightBlue[700],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue[700],
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Downloading: $title',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.lightBlue[700],
                                ),
                              );
                            },
                            child: Text('Download'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue[700],
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Opening: $title',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.lightBlue[700],
                                ),
                              );
                            },
                            child: Text('Open'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Text(
              '${index + 1}.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _selectedIndex == index
                    ? Colors.lightBlue[700]
                    : Colors.black54,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  color: _selectedIndex == index
                      ? Colors.lightBlue[700]
                      : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> generalItems = [
  {'title': 'Security Aspects for use of E-tokens'},
  {'title': 'Procedure for Public Key Export from E-token'},
  {'title': 'List of Special Characters Not Allowed as Input/Upload'},
  {'title': 'Getting Your System Ready for IREPS Application'},
  {'title': 'IREPS Security Tips'},
  {
    'title':
    'Guidelines for Procurement, Use, and Management of Encryption Certificate Version 2.0'
  },
  {'title': 'Procedure for Mapping Party Codes and Viewing Status of Bills'},
  {
    'title':
    'User Manual for Contractors/Suppliers for Online Bill Tracking Version 1.0'
  },
  {
    'title':
    'User Manual for Registration of New Vendors and Contractors Version 1.0'
  },
  {'title': 'User Manual for Creation/Change of Primary User (Vendors)'},
];