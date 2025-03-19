import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrap Listing App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        useMaterial3: true,
      ),
      home: const ScrapListingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Models
class ScrapLot {
  final int id;
  final String railway;
  final String depotName;
  final String lotNo;
  final String category;
  final int minIncr;
  final String lotPublished;
  final String material;

  ScrapLot({
    required this.id,
    required this.railway,
    required this.depotName,
    required this.lotNo,
    required this.category,
    required this.minIncr,
    required this.lotPublished,
    required this.material,
  });
}

// Mock Data Repository
class ScrapLotRepository {
  static List<ScrapLot> getAllScrapLots() {
    return [
      ScrapLot(
        id: 1,
        railway: 'BLW',
        depotName: 'GSD DLW',
        lotNo: '6600461224',
        category: 'Depot Ferrous Scrap',
        minIncr: 100,
        lotPublished: '30-12-2024 18:19:59',
        material: 'SCRAP G.I. ITEMS SUCH AS COOLER BODY WITH OR WITHO',
      ),
      ScrapLot(
        id: 2,
        railway: 'BLW',
        depotName: 'GSD DLW',
        lotNo: '6600560125',
        category: 'Depot Miscellaneous Scrap',
        minIncr: 1,
        lotPublished: '20-01-2025 16:48:20',
        material: 'SCRAP RUBBER TYRE & TUBES OF LIFTER,JUMBO AND FOUR',
      ),
      ScrapLot(
        id: 3,
        railway: 'EAST CENTRAL RLY',
        depotName: 'DDU SALE DEPOT STORES',
        lotNo: '3621720225',
        category: 'Others',
        minIncr: 500,
        lotPublished: '04-02-2025 18:37:04',
        material: 'SCRAP WAGON(1)SER 1007946,BOXNMI(2)SER 1007946',
      ),
      ScrapLot(
        id: 4,
        railway: 'BLW',
        depotName: 'GSD DLW',
        lotNo: '6600550125',
        category: 'Depot Non Ferrous Scrap',
        minIncr: 10,
        lotPublished: '20-01-2025 16:48:20',
        material: 'SCRAP CUT PIECES OF MULTI CORE COPPER CABLE OF SOR',
      ),
      ScrapLot(
        id: 5,
        railway: 'BLW',
        depotName: 'GSD DLW',
        lotNo: '6600620125',
        category: 'Depot Miscellaneous Scrap',
        minIncr: 1,
        lotPublished: '20-01-2025 16:48:20',
        material: 'SCRAP ELECTRICAL CHOKE OF SORT & SIZES DIFFERENT C',
      ),
    ];
  }
}

class ScrapListingPage extends StatefulWidget {
  const ScrapListingPage({super.key});

  @override
  State<ScrapListingPage> createState() => _ScrapListingPageState();
}

class _ScrapListingPageState extends State<ScrapListingPage> {
  // State variables
  int _currentPage = 0;
  final int _recordsPerPage = 3;
  String _selectedRailway = 'All';
  String _selectedDepot = 'All';
  String _selectedCategory = 'All';
  String _selectedDate = '';

  // Data
  late final List<ScrapLot> _allScrapLots;

  @override
  void initState() {
    super.initState();
    _allScrapLots = ScrapLotRepository.getAllScrapLots();
  }

  // Filtering logic
  List<ScrapLot> get _filteredScrapLots {
    return _allScrapLots.where((lot) {
      bool railwayMatch = _selectedRailway == 'All' || lot.railway == _selectedRailway;
      bool depotMatch = _selectedDepot == 'All' || lot.depotName == _selectedDepot;
      bool categoryMatch = _selectedCategory == 'All' || lot.category == _selectedCategory;
      bool dateMatch = _selectedDate.isEmpty || lot.lotPublished.contains(_selectedDate);

      return railwayMatch && depotMatch && categoryMatch && dateMatch;
    }).toList();
  }

  // Pagination logic
  List<ScrapLot> get _paginatedScrapLots {
    final startIndex = _currentPage * _recordsPerPage;
    final endIndex = startIndex + _recordsPerPage;

    if (startIndex >= _filteredScrapLots.length) {
      return [];
    }

    if (endIndex > _filteredScrapLots.length) {
      return _filteredScrapLots.sublist(startIndex);
    }

    return _filteredScrapLots.sublist(startIndex, endIndex);
  }

  int get _totalPages => (_filteredScrapLots.length / _recordsPerPage).ceil();

  // Navigation methods
  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  void _firstPage() {
    setState(() {
      _currentPage = 0;
    });
  }

  void _lastPage() {
    setState(() {
      _currentPage = _totalPages - 1;
    });
  }

  // Build methods
  Widget _buildPaginationBar(int startRecord, int endRecord, int totalRecords) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: Colors.blue.shade50,
      child: Row(
        children: [
          // Pagination controls
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.first_page, size: 20),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: _currentPage > 0 ? _firstPage : null,
                color: Colors.blue.shade800,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left, size: 20),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: _currentPage > 0 ? _previousPage : null,
                color: Colors.blue.shade800,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 20),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: _currentPage < _totalPages - 1 ? _nextPage : null,
                color: Colors.blue.shade800,
              ),
              IconButton(
                icon: const Icon(Icons.last_page, size: 20),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: _currentPage < _totalPages - 1 ? _lastPage : null,
                color: Colors.blue.shade800,
              ),
            ],
          ),
          const Spacer(),
          // Record counter
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              totalRecords == 0
                  ? '0 Records'
                  : '$startRecord-$endRecord of $totalRecords',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrapLotCard(ScrapLot lot) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${lot.id}. ',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  lot.railway,
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1, height: 16),

            // Info rows with consistent styling
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Depot', lot.depotName),
                const SizedBox(height: 4),
                _buildInfoRow('Lot No', lot.lotNo),
                const SizedBox(height: 4),
                _buildInfoRow('Category', lot.category),
                const SizedBox(height: 4),
                _buildInfoRow('Min Incr', '₹${lot.minIncr}', valueColor: Colors.green.shade700),
                const SizedBox(height: 4),
                _buildInfoRow('Published', lot.lotPublished,
                  dateColor: Colors.indigo.shade600,
                  timeColor: Colors.indigo.shade600,
                ),
                const SizedBox(height: 4),
                _buildInfoRow('Material', lot.material, isMaterial: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {Color? valueColor, Color? dateColor, Color? timeColor, bool isMaterial = false}) {

    // Split date and time for different colors if applicable
    List<String> dateTimeParts = label == 'Published'
        ? value.split(' ')
        : [value];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Fixed-width label container
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
        // Content with appropriate styling
        Expanded(
          child: label == 'Published'
              ? RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: dateTimeParts[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: dateColor ?? Colors.black,
                    fontSize: 13,
                  ),
                ),
                if (dateTimeParts.length > 1)
                  TextSpan(
                    text: ' ${dateTimeParts[1]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: timeColor ?? Colors.black,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
          )
              : Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
              fontSize: 13,
            ),
            overflow: isMaterial ? TextOverflow.ellipsis : TextOverflow.visible,
            maxLines: isMaterial ? 2 : 1,
          ),
        ),
      ],
    );
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final startRecord = _filteredScrapLots.isEmpty ? 0 : _currentPage * _recordsPerPage + 1;
    final endRecord = _filteredScrapLots.isEmpty ? 0 : startRecord + _paginatedScrapLots.length - 1;
    final totalRecords = _filteredScrapLots.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        title: const Text('Published Lots (Sale)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFilterDialog,
            tooltip: 'Filter',
          ),
        ],
      ),
      body: Column(
        children: [
          // Pagination controls and record counter
          _buildPaginationBar(startRecord, endRecord, totalRecords),

          // List of scrap lots
          Expanded(
            child: _paginatedScrapLots.isEmpty
                ? const Center(child: Text('No records found'))
                : ListView.builder(
              itemCount: _paginatedScrapLots.length,
              itemBuilder: (context, index) {
                final lot = _paginatedScrapLots[index];
                return _buildScrapLotCard(lot);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String tempRailway = _selectedRailway;
        String tempDepot = _selectedDepot;
        String tempDate = _selectedDate;

        return StatefulBuilder(
          builder: (context, dialogSetState) {
            final uniqueRailways = _allScrapLots
                .map((lot) => lot.railway)
                .toSet()
                .toList()
              ..sort()
              ..insert(0, 'All');

            final depotOptions = tempRailway == 'All'
                ? _allScrapLots.map((lot) => lot.depotName).toSet().toList()
                : _allScrapLots
                .where((lot) => lot.railway == tempRailway)
                .map((lot) => lot.depotName)
                .toSet()
                .toList()
              ..sort()
              ..insert(0, 'All');

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.filter_list, color: Colors.blue[800], size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Advanced Filters',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.blue[800], size: 20),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: tempRailway,
                      decoration: InputDecoration(
                        labelText: 'Railway',
                        prefixIcon: Icon(Icons.train, color: Colors.blue[800], size: 18),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                      items: uniqueRailways.map((railway) => DropdownMenuItem(
                        value: railway,
                        child: Text(railway, overflow: TextOverflow.ellipsis),
                      )).toList(),
                      onChanged: (value) {
                        dialogSetState(() {
                          tempRailway = value ?? 'All';
                          tempDepot = 'All';
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: tempDepot,
                      decoration: InputDecoration(
                        labelText: 'Depot',
                        prefixIcon: Icon(Icons.warehouse, color: Colors.blue[800], size: 18),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                      items: depotOptions.map((depot) => DropdownMenuItem(
                        value: depot,
                        child: Text(depot, overflow: TextOverflow.ellipsis),
                      )).toList(),
                      onChanged: tempRailway == 'All'
                          ? null
                          : (value) {
                        dialogSetState(() {
                          tempDepot = value ?? 'All';
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today, color: Colors.blue[800], size: 18),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                      controller: TextEditingController(text: tempDate),
                      readOnly: true,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2026),
                        );
                        if (picked != null) {
                          final formattedDate =
                              "${picked.day.toString().padLeft(2, '0')}-"
                              "${picked.month.toString().padLeft(2, '0')}-"
                              "${picked.year}";
                          dialogSetState(() {
                            tempDate = formattedDate;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.blue[800]!, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              dialogSetState(() {
                                tempRailway = 'All';
                                tempDepot = 'All';
                                tempDate = '';
                              });
                            },
                            child: Text('Reset', style: TextStyle(color: Colors.blue[800])),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[800],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedRailway = tempRailway;
                                _selectedDepot = tempDepot;
                                _selectedDate = tempDate;
                                _currentPage = 0;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Apply'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}