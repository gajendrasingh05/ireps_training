import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auction App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          primary: const Color(0xFF1565C0),
          secondary: const Color(0xFF64B5F6),
          background: Colors.grey[50]!,
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          surfaceTintColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          bodyLarge: TextStyle(fontSize: 14, letterSpacing: 0.25),
          bodyMedium: TextStyle(fontSize: 13, letterSpacing: 0.25),
          labelMedium: TextStyle(fontSize: 12, letterSpacing: 0.4, fontWeight: FontWeight.w500),
        ),
      ),
      home: const AuctionListingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuctionListingPage extends StatefulWidget {
  const AuctionListingPage({super.key});

  @override
  State<AuctionListingPage> createState() => _AuctionListingPageState();
}

class _AuctionListingPageState extends State<AuctionListingPage> {
  bool _showSearch = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Original auction items
  final List<Map<String, dynamic>> _auctions = [
    {
      'index': '1',
      'title': 'NORTH CENTRAL RLY / GSD/KANPUR',
      'catalogueNo': 'CNB20240024',
      'startTime': '18/02/25 12:00',
      'endTime': '18/02/25 12:45',
    },
    {
      'index': '2',
      'title': 'SOUTH EASTERN RLY / RANCHI DIVISION',
      'catalogueNo': '2425043FEB2503',
      'startTime': '18/02/25 12:00',
      'endTime': '18/02/25 13:15',
    },
    {
      'index': '3',
      'title': 'CENTRAL RLY / BHUSAWAL DIVISION-STORES',
      'catalogueNo': 'CRBSL02202050334',
      'startTime': '18/02/25 11:30',
      'endTime': '18/02/25 12:55',
    },
    {
      'index': '4',
      'title': 'CENTRAL RLY / MATUNGA',
      'catalogueNo': 'RWP-Depot/RWP-032025-1/18',
      'startTime': '03/03/25 12:30',
      'endTime': '03/03/25 13:05',
    },
    {
      'index': '5',
      'title': 'SAMASTIPUR DIV -SALE DEPOT-STORES',
      'catalogueNo': 'ECR-SPJ DIV-032025-1/48',
      'startTime': '03/03/25 12:30',
      'endTime': '03/03/25 16:35',
    },
  ];

  // Filtered auction items based on search
  List<Map<String, dynamic>> get _filteredAuctions {
    if (_searchQuery.isEmpty) {
      return _auctions;
    }

    final query = _searchQuery.toLowerCase();
    return _auctions.where((auction) {
      return auction['title'].toLowerCase().contains(query) ||
          auction['catalogueNo'].toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Common categories list for all cards
    final List<String> commonCategories = [
      'Others',
      'Rolling Stock',
      'Depot Non-Ferrous Scrap',
      'Depot Miscellaneous Scrap',
      'Depot Ferrous Scrap',
      'Pway Scrap'
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: _showSearch
            ? TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search auctions...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        )
            : const Text('Upcoming Auctions'),
        leading: _showSearch
            ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              _showSearch = false;
              _searchQuery = '';
              _searchController.clear();
            });
          },
        )
            : IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.clear : Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) {
                  _searchQuery = '';
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: _filteredAuctions.length,
        itemBuilder: (context, index) {
          final auction = _filteredAuctions[index];
          return ImprovedAuctionCard(
            index: auction['index'],
            title: auction['title'],
            catalogueNo: auction['catalogueNo'],
            startTime: auction['startTime'],
            endTime: auction['endTime'],
            categories: commonCategories,
          );
        },
      ),
    );
  }
}

class ImprovedAuctionCard extends StatelessWidget {
  final String index;
  final String title;
  final String catalogueNo;
  final String startTime;
  final String endTime;
  final List<String> categories;

  const ImprovedAuctionCard({
    super.key,
    required this.index,
    required this.title,
    required this.catalogueNo,
    required this.startTime,
    required this.endTime,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Always show LIVE badge as requested
    const bool isLive = true;

    // Using Colors.lightBlue[800] with a lower opacity for a lighter background
    final categoriesBgColor = Colors.lightBlue[800]!.withOpacity(0.08);
    final categoriesBorderColor = Colors.lightBlue[800]!.withOpacity(0.2);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // Here we could navigate to details page
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index}.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.receipt_outlined,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Catalogue No : ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    catalogueNo,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[700],
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isLive)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green[200]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.green[600],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'LIVE',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Divider(height: 1),
                  ),
                  // Time information - centered in the card
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Start time with label
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                startTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 20,
                              width: 1,
                              color: Colors.grey[300],
                            ),
                          ),
                          // End time with label
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'End',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                endTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Categories section with horizontal scrolling and lighter blue background
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: categoriesBgColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: categoriesBorderColor),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}