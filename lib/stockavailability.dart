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
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const StockAvailabilityScreen(),
    );
  }
}

class StockAvailabilityScreen extends StatefulWidget {
  const StockAvailabilityScreen({Key? key}) : super(key: key);

  @override
  State<StockAvailabilityScreen> createState() => _StockAvailabilityScreenState();
}

class _StockAvailabilityScreenState extends State<StockAvailabilityScreen> {
  final TextEditingController _monthsController = TextEditingController(text: '3');
  String _selectedReportCriteria = 'AAC Basis';
  String _selectedStockAvailability = 'Greater than (>)';

  // Flags to track which filters have been added
  bool _hasItemType = false;
  bool _hasItemUsage = false;
  bool _hasItemCategory = false;
  bool _hasStockType = false;

  // Values for the added filters
  String _itemType = "Consumable";
  String _itemUsage = "Regular";
  String _itemCategory = "A";
  String _stockType = "Stock";

  // Sample options for filters
  final List<String> itemTypeOptions = ["Consumable", "Non-Consumable", "Equipment", "Tools"];
  final List<String> itemUsageOptions = ["Regular", "Emergency", "Backup", "Special"];
  final List<String> itemCategoryOptions = ["A", "B", "C", "D"];
  final List<String> stockTypeOptions = ["Stock", "Non-Stock"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove default SafeArea to allow AppBar to extend to top edge
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Added extra space here
                  const SizedBox(height: 16),
                  _buildDropdownField('Railway', 'IREPS-TESTING'),
                  const SizedBox(height: 24),
                  _buildDropdownField('Unit Type', 'Zonal HQ / PU HQ'),
                  const SizedBox(height: 24),
                  _buildDropdownField('Unit Name', 'EPS/UD'),
                  const SizedBox(height: 24),
                  _buildDropdownField('Department', 'Mechanical'),
                  const SizedBox(height: 24),
                  _buildDropdownField('User Depot', '36640-SR. SECTION ENGINEER-I/PS/NEW DELHI'),
                  const SizedBox(height: 24),
                  _buildDropdownField('User Sub Depot', '00-SSE/EPS/UD'),
                  const SizedBox(height: 28),
                  _buildReportCriteriaSection(),
                  const SizedBox(height: 28),
                  _buildStockAvailabilitySection(),
                  const SizedBox(height: 28),

                  // Additional Filters section with matching style
                  _buildAdditionalFiltersSection(),

                  const SizedBox(height: 28),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    // Use MediaQuery to get the status bar height and ensure the AppBar extends properly
    return Builder(
        builder: (context) {
          final statusBarHeight = MediaQuery.of(context).padding.top;

          return Container(
            padding: EdgeInsets.only(
              top: statusBarHeight, // This ensures the AppBar extends to the top edge
              left: 8.0,
              right: 8.0,
              bottom: 12.0,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                const Text(
                  'Stock Availability',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          );
        }
    );
  }

  // Updated dropdown field with label on the edge of the box
  Widget _buildDropdownField(String label, String value) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade50,
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue.shade800,
              ),
            ],
          ),
        ),
        Positioned(
          left: 12,
          top: -10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportCriteriaSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.blue.shade800,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Select Report Criteria',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedReportCriteria = 'AAC Basis';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedReportCriteria == 'AAC Basis'
                          ? Colors.blue.shade800
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _selectedReportCriteria == 'AAC Basis'
                          ? [
                        BoxShadow(
                          color: Colors.blue.shade200.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'AAC Basis',
                      style: TextStyle(
                        color: _selectedReportCriteria == 'AAC Basis'
                            ? Colors.white
                            : Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedReportCriteria = 'Threshold Limit Basis';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedReportCriteria == 'Threshold Limit Basis'
                          ? Colors.blue.shade800
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _selectedReportCriteria == 'Threshold Limit Basis'
                          ? [
                        BoxShadow(
                          color: Colors.blue.shade200.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Threshold Limit',
                      style: TextStyle(
                        color: _selectedReportCriteria == 'Threshold Limit Basis'
                            ? Colors.white
                            : Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockAvailabilitySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                color: Colors.blue.shade800,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Select Stock Availability',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Keep the original button-style selection for Greater than/Less than
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStockAvailability = 'Greater than (>)';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedStockAvailability == 'Greater than (>)'
                          ? Colors.blue.shade800
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _selectedStockAvailability == 'Greater than (>)'
                          ? [
                        BoxShadow(
                          color: Colors.blue.shade200.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: _selectedStockAvailability == 'Greater than (>)'
                              ? Colors.white
                              : Colors.grey.shade800,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Greater than (>)',
                          style: TextStyle(
                            color: _selectedStockAvailability == 'Greater than (>)'
                                ? Colors.white
                                : Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStockAvailability = 'Less than (<=)';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedStockAvailability == 'Less than (<=)'
                          ? Colors.blue.shade800
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _selectedStockAvailability == 'Less than (<=)'
                          ? [
                        BoxShadow(
                          color: Colors.blue.shade200.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.trending_down,
                          color: _selectedStockAvailability == 'Less than (<=)'
                              ? Colors.white
                              : Colors.grey.shade800,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Less than (<=)',
                          style: TextStyle(
                            color: _selectedStockAvailability == 'Less than (<=)'
                                ? Colors.white
                                : Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Improved months input field with proper labeling
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade50,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.blue.shade800,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _monthsController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter number of months',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 12,
                top: -10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.white,
                  child: Text(
                    'Months based on AAC',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Optional: Information text about this field
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Enter the number of months to calculate stock availability based on AAC',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated Additional Filters section with the same style as Stock Availability
  Widget _buildAdditionalFiltersSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                color: Colors.blue.shade800,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Additional Filters',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Show dynamically added filters if they exist
          if (_hasItemType) ...[
            _buildSearchableDropdown("Item Type", _itemType, itemTypeOptions, (value) {
              setState(() => _itemType = value);
            }, Icons.category),
            const SizedBox(height: 16),
          ],

          if (_hasItemUsage) ...[
            _buildSearchableDropdown("Item Usage", _itemUsage, itemUsageOptions, (value) {
              setState(() => _itemUsage = value);
            }, Icons.handyman),
            const SizedBox(height: 16),
          ],

          if (_hasItemCategory) ...[
            _buildSearchableDropdown("Item Category", _itemCategory, itemCategoryOptions, (value) {
              setState(() => _itemCategory = value);
            }, Icons.label),
            const SizedBox(height: 16),
          ],

          if (_hasStockType) ...[
            _buildSearchableDropdown("Stock/Non-Stock", _stockType, stockTypeOptions, (value) {
              setState(() => _stockType = value);
            }, Icons.inventory_2),
            const SizedBox(height: 16),
          ],

          const SizedBox(height: 8),

          // Filter chips for adding new filters
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FilterChip(
                avatar: CircleAvatar(
                  backgroundColor: _hasItemType ? Colors.grey : Colors.blue.shade800,
                  child: Icon(Icons.add, size: 18, color: Colors.white),
                ),
                label: Text("Item Type"),
                labelStyle: TextStyle(
                  color: _hasItemType ? Colors.grey : Colors.blue.shade800,
                  fontWeight: FontWeight.w500,
                ),
                selected: _hasItemType,
                selectedColor: Colors.blue.shade100,
                backgroundColor: Colors.grey.shade100,
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
                    color: _hasItemType ? Colors.grey.shade300 : Colors.blue.shade800.withOpacity(0.5),
                  ),
                ),
              ),

              FilterChip(
                avatar: CircleAvatar(
                  backgroundColor: _hasItemUsage ? Colors.grey : Colors.blue.shade800,
                  child: Icon(Icons.add, size: 18, color: Colors.white),
                ),
                label: Text("Item Usage"),
                labelStyle: TextStyle(
                  color: _hasItemUsage ? Colors.grey : Colors.blue.shade800,
                  fontWeight: FontWeight.w500,
                ),
                selected: _hasItemUsage,
                selectedColor: Colors.blue.shade100,
                backgroundColor: Colors.grey.shade100,
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
                    color: _hasItemUsage ? Colors.grey.shade300 : Colors.blue.shade800.withOpacity(0.5),
                  ),
                ),
              ),

              FilterChip(
                avatar: CircleAvatar(
                  backgroundColor: _hasItemCategory ? Colors.grey : Colors.blue.shade800,
                  child: Icon(Icons.add, size: 18, color: Colors.white),
                ),
                label: Text("Item Category"),
                labelStyle: TextStyle(
                  color: _hasItemCategory ? Colors.grey : Colors.blue.shade800,
                  fontWeight: FontWeight.w500,
                ),
                selected: _hasItemCategory,
                selectedColor: Colors.blue.shade100,
                backgroundColor: Colors.grey.shade100,
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
                    color: _hasItemCategory ? Colors.grey.shade300 : Colors.blue.shade800.withOpacity(0.5),
                  ),
                ),
              ),

              FilterChip(
                avatar: CircleAvatar(
                  backgroundColor: _hasStockType ? Colors.grey : Colors.blue.shade800,
                  child: Icon(Icons.add, size: 18, color: Colors.white),
                ),
                label: Text("Stock/Non-Stock"),
                labelStyle: TextStyle(
                  color: _hasStockType ? Colors.grey : Colors.blue.shade800,
                  fontWeight: FontWeight.w500,
                ),
                selected: _hasStockType,
                selectedColor: Colors.blue.shade100,
                backgroundColor: Colors.grey.shade100,
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
                    color: _hasStockType ? Colors.grey.shade300 : Colors.blue.shade800.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build searchable dropdown with positioned label
  Widget _buildSearchableDropdown(String label, String value, List<String> options, Function(String) onChanged, IconData iconData) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade100),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade50,
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(iconData, color: Colors.blue.shade800, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.blue.shade800),
            ],
          ),
        ),
        Positioned(
          left: 12,
          top: -10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              elevation: 3,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Get Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue.shade800,
              side: BorderSide(color: Colors.blue.shade800, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              setState(() {
                _monthsController.text = '3';
                _selectedReportCriteria = 'AAC Basis';
                _selectedStockAvailability = 'Greater than (>)';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh, color: Colors.blue.shade800),
                const SizedBox(width: 8),
                Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}