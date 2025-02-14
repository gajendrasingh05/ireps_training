import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search PO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SearchPOPage(),
    );
  }
}

class SearchPOPage extends StatefulWidget {
  const SearchPOPage({super.key});

  @override
  State<SearchPOPage> createState() => _SearchPOPageState();
}

class _SearchPOPageState extends State<SearchPOPage> {
  bool isZonalSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Search PO',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.blue.shade800,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => setState(() => isZonalSelected = true),
                  child: _buildTab('Search PO (Zonal)', isZonalSelected),
                ),
                GestureDetector(
                  onTap: () => setState(() => isZonalSelected = false),
                  child: _buildTab('Search PO (Other)', !isZonalSelected),
                ),
              ],
            ),
          ),
          if (!isZonalSelected) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              //color: Colors.blue.shade100,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Other Zonal Railways',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade50,  // Light background color for the entire list area
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85, // Increased width to 85%
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView(
                      children: _buildButtons(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isSelected ? Colors.white : Colors.white70,
      ),
    );
  }

  List<Widget> _buildButtons() {
    final railways = [
      {'code': '  BLW', 'place': 'Varanasi'},
      {'code': '  ICF', 'place': 'Perambur'},
      {'code': '     RCF', 'place': 'Kapurthala'},
      {'code': '   MCF', 'place': 'Raebareli'},
      {'code': '       CLW', 'place': 'Chittaranjan'},
      {'code': 'DMW', 'place': 'Patiala'},
      {'code': '     RWF', 'place': 'Bangalore'},
      {'code': '        CORE', 'place': 'Allahabad'},
    ];

    return railways.map((railway) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0), // Increased vertical spacing
        child: Container(
          height: 65, // Fixed height for uniform buttons
          child: ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              foregroundColor: Colors.blue.shade800,
              elevation: 3,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Increased padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Slightly more rounded corners
                side: BorderSide(color: Colors.blue.shade800, width: 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${railway['code']} - ${railway['place']}',
                  style: TextStyle(
                    fontSize: 18, // Increased font size
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}