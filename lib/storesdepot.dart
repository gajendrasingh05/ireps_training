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
        fontFamily: 'Roboto',
        primaryColor: Colors.blue[800],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue[800],
          secondary: Colors.white,
        ),
      ),
      home: StoresDepotStockPage(),
    );
  }
}

class StoresDepotStockPage extends StatefulWidget {
  @override
  _StoresDepotStockPageState createState() => _StoresDepotStockPageState();
}

class _StoresDepotStockPageState extends State<StoresDepotStockPage> {
  String selectedRailway = 'IREPS-TESTING';
  String selectedStoreDepot = 'All';
  TextEditingController plController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 2,
        centerTitle: false,
        titleSpacing: 0,
        leadingWidth: 40,
        toolbarHeight: 60, // Increased from 50 to 60
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24), // Slightly increased icon size
          padding: EdgeInsets.zero,
          onPressed: () {
            // Handle back navigation
          },
        ),
        title: Text(
          'Stores Depot Stock',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20, // Slightly increased font size
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Railway Field
                      _buildFieldLabel('Railway'),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue[800]!),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedRailway,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            border: InputBorder.none,
                            hintText: "Select Railway",
                          ),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.blue[800]),
                          dropdownColor: Colors.white,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRailway = newValue!;
                            });
                          },
                          items: <String>['IREPS-TESTING']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Stores Depot Field
                      _buildFieldLabel('Stores Depot'),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue[800]!),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedStoreDepot,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            border: InputBorder.none,
                            hintText: "Select Stores Depot",
                          ),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.blue[800]),
                          dropdownColor: Colors.white,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedStoreDepot = newValue!;
                            });
                          },
                          items: <String>['All']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // PL No/Description Field
                      _buildFieldLabel('PL No/Description'),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue[800]!),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: plController,
                          decoration: InputDecoration(
                            hintText: 'Enter PL/ minimum 3 letters of description',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Action Buttons with Blue and White Theme
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle get details action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                shadowColor: Colors.blue.withOpacity(0.5),
                              ),
                              child: Text(
                                'GET DETAILS',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle reset action
                                setState(() {
                                  selectedRailway = 'IREPS-TESTING';
                                  selectedStoreDepot = 'All';
                                  plController.clear();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue[800],
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.blue[800]!),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'RESET',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.blue[800]!,
            width: 3,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }
}