import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.white,
        // Set global popup menu theme to white
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
        ),
      ),
      home: const StockHistoryPage(),
    );
  }
}

class StockHistoryPage extends StatefulWidget {
  const StockHistoryPage({Key? key}) : super(key: key);

  @override
  State<StockHistoryPage> createState() => _StockHistoryPageState();
}

class _StockHistoryPageState extends State<StockHistoryPage> {
  final TextEditingController _plController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String selectedRailway = "Select Railway";
  final List<String> railways = ["Select Railway", "IREPS-TESTING", "NORTHERN", "WESTERN", "SOUTHERN"];
  bool _showSearchBar = false;

  void _toggleSearch() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (!_showSearchBar) {
        _searchController.clear();
      }
    });
  }

  void _performSearch(String query) {
    // Here you would implement the actual search functionality
    print('Searching for: $query');
    // You could filter your data based on the query here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showSearchBar
          ? AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _toggleSearch,
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Search stock items...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
        ),
        // Removed the clear (X) button from here
      )
          : AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: const Text(
          "Stock Item History Sheet",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _toggleSearch,
          ),
          Theme(
            data: Theme.of(context).copyWith(
              // Specifically set the popup menu color to white for the three dots menu
              popupMenuTheme: const PopupMenuThemeData(
                color: Colors.white,
              ),
            ),
            child: PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'clear',
                  child: Text('Reset Fields'),
                ),
                const PopupMenuItem(
                  value: 'exit',
                  child: Text('Close Page'),
                ),
              ],
              onSelected: (value) {
                if (value == 'clear') {
                  _plController.clear();
                  setState(() {
                    selectedRailway = "Select Railway";
                  });
                } else if (value == 'exit') {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main content with straight edges
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Railway Division",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        // Change dropdown menu background color to white
                        popupMenuTheme: const PopupMenuThemeData(
                          color: Colors.white,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedRailway,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          borderRadius: BorderRadius.circular(12),
                          dropdownColor: Colors.white, // Set dropdown color to white
                          items: railways.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRailway = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Part List Reference:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _plController,
                          decoration: InputDecoration(
                            hintText: "Enter PL number or code",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text(
                          "Search",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stock Item History Results (0)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.inventory_2,
                                    size: 80,
                                    color: Colors.blue.shade700,
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.blue.shade200, width: 2),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.blue.shade800,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              "Please select a railway division and enter part list details\nto view the inventory history.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}