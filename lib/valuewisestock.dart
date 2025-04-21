import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Value-Wise Stock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      home: const ValueWiseStockScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ValueWiseStockScreen extends StatefulWidget {
  const ValueWiseStockScreen({Key? key}) : super(key: key);

  @override
  _ValueWiseStockScreenState createState() => _ValueWiseStockScreenState();
}

class _ValueWiseStockScreenState extends State<ValueWiseStockScreen> {
  final TextEditingController _minValueController = TextEditingController(text: "10000");
  final TextEditingController _maxValueController = TextEditingController();

  // Comparison type for stock availability
  String _comparisonType = "greater"; // "greater", "less"

  // Initial dropdown values
  String _railway = "IREPS-TESTING";
  String _unitType = "Zonal HQ / PU HQ";
  String _unitName = "EPS/UD";
  String _department = "Mechanical";
  String _userDepot = "36640-SR. SECTION ENGINEER-I/PS/NEW DELHI";
  String _userSubDepot = "00-SSE/EPS/UD";

  // Dynamic fields flags - to track if they've been added
  bool _hasItemType = false;
  bool _hasItemUsage = false;
  bool _hasItemCategory = false;
  bool _hasStockType = false;

  // Values for dynamic fields
  String _itemType = "Consumable";
  String _itemUsage = "Regular";
  String _itemCategory = "A";
  String _stockType = "Stock";

  // Sample dropdown options
  final List<String> railwayOptions = ["IREPS-TESTING", "Northern Railway", "Southern Railway", "Western Railway", "Eastern Railway"];
  final List<String> unitTypeOptions = ["Zonal HQ / PU HQ", "Division", "Workshop", "Depot"];
  final List<String> unitNameOptions = ["EPS/UD", "DLW", "CLW", "ICF", "RCF"];
  final List<String> departmentOptions = ["Mechanical", "Electrical", "Civil", "Signal", "Telecom"];
  final List<String> depotOptions = ["36640-SR. SECTION ENGINEER-I/PS/NEW DELHI", "Depot A", "Depot B", "Depot C"];
  final List<String> subDepotOptions = ["00-SSE/EPS/UD", "Sub Depot A", "Sub Depot B", "Sub Depot C"];

  // Sample options for dynamic fields
  final List<String> itemTypeOptions = ["Consumable", "Non-Consumable", "Equipment", "Tools"];
  final List<String> itemUsageOptions = ["Regular", "Emergency", "Backup", "Special"];
  final List<String> itemCategoryOptions = ["A", "B", "C", "D"];
  final List<String> stockTypeOptions = ["Stock", "Non-Stock"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Value-Wise Stock',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF1565C0), // Deeper blue
        elevation: 0, // Remove shadow
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle back button
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle home button
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[50], // Light background

      body: Stack(
        children: [
          // Decorative top curved background
          Container(
            height: 80,
            width: double.infinity,
            color: Color(0xFF1565C0),
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),

          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Main form card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 16),

                        // Main dropdown fields with improved styling
                        buildSearchableDropdown("Railway", _railway, railwayOptions, (value) {
                          setState(() => _railway = value);
                        }, Icons.train),
                        const SizedBox(height: 16),

                        buildSearchableDropdown("Unit Type", _unitType, unitTypeOptions, (value) {
                          setState(() => _unitType = value);
                        }, Icons.business),
                        const SizedBox(height: 16),

                        buildSearchableDropdown("Unit Name", _unitName, unitNameOptions, (value) {
                          setState(() => _unitName = value);
                        }, Icons.location_city),
                        const SizedBox(height: 16),

                        buildSearchableDropdown("Department", _department, departmentOptions, (value) {
                          setState(() => _department = value);
                        }, Icons.work),
                        const SizedBox(height: 16),

                        buildSearchableDropdown("User Depot", _userDepot, depotOptions, (value) {
                          setState(() => _userDepot = value);
                        }, Icons.warehouse),
                        const SizedBox(height: 16),

                        buildSearchableDropdown("User Sub Depot", _userSubDepot, subDepotOptions, (value) {
                          setState(() => _userSubDepot = value);
                        }, Icons.store),
                        const SizedBox(height: 16),

                        // Modified Stock Value Criteria section with min-max layout
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                              child: Text(
                                "Stock Value Criteria (in Rs.)",
                                style: TextStyle(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade50,
                              ),
                              child: Row(
                                children: [
                                  // Minimum value field
                                  Expanded(
                                    child: TextFormField(
                                      controller: _minValueController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Min Value",
                                        prefixIcon: Icon(Icons.currency_rupee, color: Color(0xFF1565C0)),
                                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),

                                  // Comparison operator in the middle
                                  Container(
                                    width: 80,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: DropdownButtonFormField<String>(
                                      value: _comparisonType,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          value: "greater",
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.keyboard_arrow_right, size: 18, color: Color(0xFF1565C0)),
                                              Text(">", style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: "less",
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.keyboard_arrow_left, size: 18, color: Color(0xFF1565C0)),
                                              Text("<", style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _comparisonType = value!;
                                        });
                                      },
                                    ),
                                  ),

                                  // Maximum value field
                                  Expanded(
                                    child: TextFormField(
                                      controller: _maxValueController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Max Value",
                                        prefixIcon: Icon(Icons.currency_rupee, color: Color(0xFF1565C0)),
                                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4.0),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Additional filters card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Additional Filters",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                        const SizedBox(height: 2),

                        // Display dynamically added fields if they exist
                        if (_hasItemType) ...[
                          buildSearchableDropdown("Item Type", _itemType, itemTypeOptions, (value) {
                            setState(() => _itemType = value);
                          }, Icons.category),
                          const SizedBox(height: 16),
                        ],

                        if (_hasItemUsage) ...[
                          buildSearchableDropdown("Item Usage", _itemUsage, itemUsageOptions, (value) {
                            setState(() => _itemUsage = value);
                          }, Icons.handyman),
                          const SizedBox(height: 16),
                        ],

                        if (_hasItemCategory) ...[
                          buildSearchableDropdown("Item Category", _itemCategory, itemCategoryOptions, (value) {
                            setState(() => _itemCategory = value);
                          }, Icons.label),
                          const SizedBox(height: 16),
                        ],

                        if (_hasStockType) ...[
                          buildSearchableDropdown("Stock/Non-Stock", _stockType, stockTypeOptions, (value) {
                            setState(() => _stockType = value);
                          }, Icons.inventory_2),
                          const SizedBox(height: 16),
                        ],

                        // Dynamic field buttons with improved styling

                        const SizedBox(height: 12),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            FilterChip(
                              avatar: CircleAvatar(
                                backgroundColor: _hasItemType ? Colors.grey : Color(0xFF1565C0),
                                child: Icon(Icons.add, size: 18, color: Colors.white),
                              ),
                              label: Text("Item Type"),
                              labelStyle: TextStyle(
                                color: _hasItemType ? Colors.grey : Color(0xFF1565C0),
                                fontWeight: FontWeight.w500,
                              ),
                              selected: _hasItemType,
                              selectedColor: Colors.blue[100],
                              backgroundColor: Colors.grey[100],
                              onSelected: _hasItemType ? null : (bool selected) {
                                if (selected) {
                                  setState(() {
                                    _hasItemType = true;
                                  });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: _hasItemType ? Colors.grey.shade300 : Color(0xFF1565C0).withOpacity(0.5),
                                ),
                              ),
                            ),

                            FilterChip(
                              avatar: CircleAvatar(
                                backgroundColor: _hasItemUsage ? Colors.grey : Color(0xFF1565C0),
                                child: Icon(Icons.add, size: 18, color: Colors.white),
                              ),
                              label: Text("Item Usage"),
                              labelStyle: TextStyle(
                                color: _hasItemUsage ? Colors.grey : Color(0xFF1565C0),
                                fontWeight: FontWeight.w500,
                              ),
                              selected: _hasItemUsage,
                              selectedColor: Colors.blue[100],
                              backgroundColor: Colors.grey[100],
                              onSelected: _hasItemUsage ? null : (bool selected) {
                                if (selected) {
                                  setState(() {
                                    _hasItemUsage = true;
                                  });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: _hasItemUsage ? Colors.grey.shade300 : Color(0xFF1565C0).withOpacity(0.5),
                                ),
                              ),
                            ),

                            FilterChip(
                              avatar: CircleAvatar(
                                backgroundColor: _hasItemCategory ? Colors.grey : Color(0xFF1565C0),
                                child: Icon(Icons.add, size: 18, color: Colors.white),
                              ),
                              label: Text("Item Category"),
                              labelStyle: TextStyle(
                                color: _hasItemCategory ? Colors.grey : Color(0xFF1565C0),
                                fontWeight: FontWeight.w500,
                              ),
                              selected: _hasItemCategory,
                              selectedColor: Colors.blue[100],
                              backgroundColor: Colors.grey[100],
                              onSelected: _hasItemCategory ? null : (bool selected) {
                                if (selected) {
                                  setState(() {
                                    _hasItemCategory = true;
                                  });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: _hasItemCategory ? Colors.grey.shade300 : Color(0xFF1565C0).withOpacity(0.5),
                                ),
                              ),
                            ),

                            FilterChip(
                              avatar: CircleAvatar(
                                backgroundColor: _hasStockType ? Colors.grey : Color(0xFF1565C0),
                                child: Icon(Icons.add, size: 18, color: Colors.white),
                              ),
                              label: Text("Stock/Non-Stock"),
                              labelStyle: TextStyle(
                                color: _hasStockType ? Colors.grey : Color(0xFF1565C0),
                                fontWeight: FontWeight.w500,
                              ),
                              selected: _hasStockType,
                              selectedColor: Colors.blue[100],
                              backgroundColor: Colors.grey[100],
                              onSelected: _hasStockType ? null : (bool selected) {
                                if (selected) {
                                  setState(() {
                                    _hasStockType = true;
                                  });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: _hasStockType ? Colors.grey.shade300 : Color(0xFF1565C0).withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Action buttons with improved styling
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Get Details action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1565C0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search),
                            const SizedBox(width: 8),
                            Text(
                              "Get Details",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Reset action
                          setState(() {
                            _railway = "IREPS-TESTING";
                            _unitType = "Zonal HQ / PU HQ";
                            _unitName = "EPS/UD";
                            _department = "Mechanical";
                            _userDepot = "36640-SR. SECTION ENGINEER-I/PS/NEW DELHI";
                            _userSubDepot = "00-SSE/EPS/UD";
                            _comparisonType = "greater";
                            _minValueController.text = "10000";
                            _maxValueController.clear();

                            // Reset dynamic fields
                            _hasItemType = false;
                            _hasItemUsage = false;
                            _hasItemCategory = false;
                            _hasStockType = false;

                            // Reset their values too
                            _itemType = "Consumable";
                            _itemUsage = "Regular";
                            _itemCategory = "A";
                            _stockType = "Stock";
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Color(0xFF1565C0), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh, color: Color(0xFF1565C0)),
                            const SizedBox(width: 8),
                            Text(
                              "Reset",
                              style: TextStyle(
                                color: Color(0xFF1565C0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build searchable dropdown with improved styling
  Widget buildSearchableDropdown(String label, String value, List<String> options, Function(String) onChanged, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.w500),
          ),
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return SearchableDropdownModal(
                  title: label,
                  options: options,
                  onSelect: onChanged,
                  currentValue: value,
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade50,
            ),
            child: Row(
              children: [
                Icon(iconData, color: Color(0xFF1565C0), size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Color(0xFF1565C0)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Searchable dropdown modal with improved styling
class SearchableDropdownModal extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelect;
  final String currentValue;

  const SearchableDropdownModal({
    Key? key,
    required this.title,
    required this.options,
    required this.onSelect,
    required this.currentValue,
  }) : super(key: key);

  @override
  _SearchableDropdownModalState createState() => _SearchableDropdownModalState();
}

class _SearchableDropdownModalState extends State<SearchableDropdownModal> {
  late TextEditingController _searchController;
  late List<String> _filteredOptions;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredOptions = List.from(widget.options);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOptions(String query) {
    setState(() {
      _filteredOptions = widget.options
          .where((option) => option.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select ${widget.title}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1565C0)),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.grey[700]),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Search field
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search ${widget.title.toLowerCase()}...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF1565C0)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              onChanged: _filterOptions,
            ),
          ),
          const SizedBox(height: 20),
          // Options list
          Expanded(
            child: _filteredOptions.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    "No results found",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            )
                : ListView.separated(
              itemCount: _filteredOptions.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                final option = _filteredOptions[index];
                final isSelected = option == widget.currentValue;

                return ListTile(
                  title: Text(
                    option,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  tileColor: isSelected ? Color(0xFF1565C0).withOpacity(0.1) : null,
                  leading: isSelected
                      ? Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Color(0xFF1565C0),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 16),
                  )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  onTap: () {
                    widget.onSelect(option);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}