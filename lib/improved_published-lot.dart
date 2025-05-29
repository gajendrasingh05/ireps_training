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
          elevation: 2,
          shadowColor: Colors.blue.shade200,
        ),
        cardTheme: CardTheme(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadowColor: Colors.grey.shade300,
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
        material: 'SCRAP G.I. ITEMS SUCH AS COOLER BODY WITH OR WITHOUT MOTOR, CONDENSER, EVAPORATOR COILS, COMPRESSOR SCRAP, FAN MOTOR SCRAP, ELECTRICAL ITEMS LIKE SWITCHES, SOCKETS, WIRES, CABLES AND OTHER MISCELLANEOUS FERROUS SCRAP MATERIALS COLLECTED FROM VARIOUS WORKSHOPS AND MAINTENANCE FACILITIES',
      ),
      ScrapLot(
        id: 2,
        railway: 'NCR',
        depotName: 'DLI EMU',
        lotNo: '6600461225',
        category: 'Rolling Stock Scrap',
        minIncr: 500,
        lotPublished: '29-12-2024 15:30:45',
        material: 'OLD LOCOMOTIVE PARTS INCLUDING BOGIES, WHEELS, AXLES, BRAKE COMPONENTS, ELECTRICAL EQUIPMENT, TRACTION MOTORS, CONTROL PANELS, WIRING HARNESSES, PNEUMATIC COMPONENTS, AND VARIOUS OTHER MECHANICAL PARTS FROM DECOMMISSIONED ROLLING STOCK UNITS',
      ),
      ScrapLot(
        id: 3,
        railway: 'WR',
        depotName: 'MUMBAI CENTRAL',
        lotNo: '6600461226',
        category: 'Infrastructure Scrap',
        minIncr: 200,
        lotPublished: '28-12-2024 10:15:30',
        material: 'SHORT MATERIAL',
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

  // Track expanded state for each card's material text
  final Map<int, bool> _expandedStates = {};

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

  // Check if text needs expansion
  bool _needsExpansion(String text, TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  // Build methods
  Widget _buildPaginationBar(int startRecord, int endRecord, int totalRecords) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Pagination controls
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPaginationButton(
                  icon: Icons.first_page,
                  onPressed: _currentPage > 0 ? _firstPage : null,
                  tooltip: 'First Page',
                ),
                _buildPaginationButton(
                  icon: Icons.chevron_left,
                  onPressed: _currentPage > 0 ? _previousPage : null,
                  tooltip: 'Previous Page',
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    '${_currentPage + 1} / $_totalPages',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade800,
                      fontSize: 14,
                    ),
                  ),
                ),
                _buildPaginationButton(
                  icon: Icons.chevron_right,
                  onPressed: _currentPage < _totalPages - 1 ? _nextPage : null,
                  tooltip: 'Next Page',
                ),
                _buildPaginationButton(
                  icon: Icons.last_page,
                  onPressed: _currentPage < _totalPages - 1 ? _lastPage : null,
                  tooltip: 'Last Page',
                ),
              ],
            ),
          ),
          const Spacer(),
          // Record counter with enhanced styling
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade400, Colors.teal.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.article_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  totalRecords == 0
                      ? '0 Records'
                      : '$startRecord-$endRecord of $totalRecords',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 20,
              color: onPressed != null ? Colors.blue.shade800 : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrapLotCard(ScrapLot lot) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with ID and Railway
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.train,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${lot.id}. ${lot.railway}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Info rows with enhanced styling
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Depot', lot.depotName),
                  const SizedBox(height: 4),
                  _buildInfoRow('Lot No', lot.lotNo),
                  const SizedBox(height: 4),
                  _buildInfoRow('Category', lot.category),
                  const SizedBox(height: 4),
                  _buildInfoRow('Min Incr', '₹${lot.minIncr}',
                      valueColor: Colors.green.shade700),
                  const SizedBox(height: 4),
                  _buildInfoRow('Published', lot.lotPublished,
                    dateColor: Colors.indigo.shade600,
                    timeColor: Colors.indigo.shade600,
                  ),
                  const SizedBox(height: 4),
                  _buildExpandableMaterialRow(lot),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableMaterialRow(ScrapLot lot) {
    final isExpanded = _expandedStates[lot.id] ?? false;
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black87,
      fontSize: 13,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - 96; // Account for label width and padding
        final needsExpansion = _needsExpansion(lot.material, textStyle, availableWidth);

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  Container(
                    width: 80,
                    child: Text(
                      'Material',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  // Material text
                  Expanded(
                    child: Text(
                      lot.material,
                      style: textStyle,
                      maxLines: isExpanded ? null : 2,
                      overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              // Show "See more" / "See less" button only if text needs expansion
              if (needsExpansion)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 80),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _expandedStates[lot.id] = !isExpanded;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isExpanded ? 'See less' : 'See more',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: Colors.blue.shade600,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value,
      {Color? valueColor, Color? dateColor, Color? timeColor}) {

    // Split date and time for different colors if applicable
    List<String> dateTimeParts = label == 'Published'
        ? value.split(' ')
        : [value];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label only (removed icon)
          Container(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
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
                      color: dateColor ?? Colors.black87,
                      fontSize: 13,
                    ),
                  ),
                  if (dateTimeParts.length > 1)
                    TextSpan(
                      text: ' ${dateTimeParts[1]}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: timeColor ?? Colors.black87,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            )
                : Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        title: const Text(
          'Published Lots (Sale)',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.tune, size: 20),
              ),
              onPressed: _showFilterDialog,
              tooltip: 'Filter',
            ),
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
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No records found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try adjusting your filters',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
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
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade600, Colors.blue.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.filter_list, color: Colors.white, size: 20),
                                const SizedBox(width: 8),
                                const Text(
                                  'Advanced Filters',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.white, size: 20),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Filter controls
                      _buildFilterDropdown(
                        label: 'Railway',
                        icon: Icons.train,
                        value: tempRailway,
                        items: uniqueRailways,
                        onChanged: (value) {
                          dialogSetState(() {
                            tempRailway = value ?? 'All';
                            tempDepot = 'All';
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      _buildFilterDropdown(
                        label: 'Depot',
                        icon: Icons.warehouse,
                        value: tempDepot,
                        items: depotOptions,
                        enabled: tempRailway != 'All',
                        onChanged: (value) {
                          dialogSetState(() {
                            tempDepot = value ?? 'All';
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      _buildDateField(tempDate, (date) {
                        dialogSetState(() {
                          tempDate = date;
                        });
                      }),
                      const SizedBox(height: 24),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.blue.shade700, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              icon: Icon(Icons.refresh, color: Colors.blue.shade700),
                              label: Text('Reset', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w600)),
                              onPressed: () {
                                dialogSetState(() {
                                  tempRailway = 'All';
                                  tempDepot = 'All';
                                  tempDate = '';
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              icon: const Icon(Icons.check),
                              label: const Text('Apply', style: TextStyle(fontWeight: FontWeight.w600)),
                              onPressed: () {
                                setState(() {
                                  _selectedRailway = tempRailway;
                                  _selectedDepot = tempDepot;
                                  _selectedDate = tempDate;
                                  _currentPage = 0;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade700, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        ),
        items: items.map((item) => DropdownMenuItem(
          value: item,
          child: Text(item, overflow: TextOverflow.ellipsis),
        )).toList(),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }

  Widget _buildDateField(String tempDate, ValueChanged<String> onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Date',
          prefixIcon: Icon(Icons.calendar_today, color: Colors.blue.shade700, size: 20),
          suffixIcon: tempDate.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: Colors.grey.shade600),
            onPressed: () => onChanged(''),
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
            onChanged(formattedDate);
          }
        },
      ),
    );
  }
}