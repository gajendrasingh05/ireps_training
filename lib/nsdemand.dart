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
      title: 'Supply Chain Dashboard',
      theme: ThemeData(
        primaryColor: Colors.blue.shade800,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800,
          primary: Colors.blue.shade800,
        ),
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _demandNoController = TextEditingController();
  final TextEditingController _itemDescriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  DateTime _fromDate = DateTime(2024, 6, 11);
  DateTime _toDate = DateTime(2025, 5, 5);

  String _statusValue = 'All';
  String _indentorValue = 'All';
  String _consigneeValue = 'All';

  // Lists for dropdown options
  final List<String> _statusOptions = ['All', 'Pending', 'Completed', 'In Progress'];
  final List<String> _indentorOptions = ['All', 'Indentor 1', 'Indentor 2', 'Indentor 3'];
  final List<String> _consigneeOptions = ['All', 'Consignee 1', 'Consignee 2', 'Consignee 3'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // This is needed to update the selected tab highlight
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _demandNoController.dispose();
    _itemDescriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Custom date formatter without using intl package
  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day-$month-$year';
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? _fromDate : _toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade800,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  // Method to show dropdown with search
  Future<void> _showDropdownSearch(
      BuildContext context,
      String title,
      List<String> items,
      String currentValue,
      Function(String) onSelect,
      ) async {
    _searchController.clear();
    List<String> filteredItems = List.from(items);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search ${title.toLowerCase()}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue.shade800),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (value) {
                        setState(() {
                          filteredItems = items
                              .where((item) => item.toLowerCase().contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return ListTile(
                            title: Text(item),
                            tileColor: item == currentValue ? Colors.blue.shade50 : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onTap: () {
                              onSelect(item);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'NS Demand',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade500], // Lighter colors than navbar
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab, // Changed to TabBarIndicatorSize.tab to accommodate longer text
              isScrollable: true, // Allow tabs to scroll if needed
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              tabs: const [
                Tab(text: 'Dashboard'),
                Tab(text: 'Forwarded/Finalised by me'),
                Tab(text: 'Awaiting Action'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFilterForm(),
                _buildDateFilterPage('My Forwarded Claims'),
                _buildDateFilterPage('My Approved/Dropped Claims'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateFilterPage(String title) {
    return Container(
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Demand Date Range',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'From',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () => _selectDate(context, true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatDate(_fromDate),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.blue.shade800,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'To',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () => _selectDate(context, false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatDate(_toDate),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.blue.shade800,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement search functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'PROCEED',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: SizedBox(), // Empty space where the "Data not found" used to be
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Dropdown with Search
          _buildFormField(
            'Status',
            _buildCustomDropdown(
              _statusValue,
              'Select Status',
                  () {
                _showDropdownSearch(
                  context,
                  'Select Status',
                  _statusOptions,
                  _statusValue,
                      (value) {
                    setState(() {
                      _statusValue = value;
                    });
                  },
                );
              },
            ),
          ),

          // Demand No
          _buildFormField(
            'Demand No.',
            TextFormField(
              controller: _demandNoController,
              decoration: _inputDecoration(hintText: 'Demand No.'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),

          // Indentor Dropdown with Search
          _buildFormField(
            'Indentor',
            _buildCustomDropdown(
              _indentorValue,
              'Select Indentor',
                  () {
                _showDropdownSearch(
                  context,
                  'Select Indentor',
                  _indentorOptions,
                  _indentorValue,
                      (value) {
                    setState(() {
                      _indentorValue = value;
                    });
                  },
                );
              },
            ),
          ),

          // Consignee Dropdown with Search
          _buildFormField(
            'Consignee',
            _buildCustomDropdown(
              _consigneeValue,
              'Select Consignee',
                  () {
                _showDropdownSearch(
                  context,
                  'Select Consignee',
                  _consigneeOptions,
                  _consigneeValue,
                      (value) {
                    setState(() {
                      _consigneeValue = value;
                    });
                  },
                );
              },
            ),
          ),

          // Date Range Section
          _buildFormField(
            'Date Range',
            _buildDateRangeSection(),
          ),

          // Item Description
          _buildFormField(
            'Item Description',
            TextFormField(
              controller: _itemDescriptionController,
              decoration: _inputDecoration(hintText: 'Item Description'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Action Buttons - Positions swapped
          Row(
            children: [
              // Reset button - now on the left
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Reset form
                    _demandNoController.clear();
                    _itemDescriptionController.clear();
                    setState(() {
                      _statusValue = 'All';
                      _indentorValue = 'All';
                      _consigneeValue = 'All';
                      _fromDate = DateTime(2024, 6, 11);
                      _toDate = DateTime(2025, 5, 5);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    side: BorderSide(color: Colors.blue.shade800, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // More oval shape
                    ),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal), // Normal font weight
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Proceed button - now on the right
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement search functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // More oval shape
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal), // Normal font weight
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDropdown(String value, String hint, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.shade800),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.blue.shade800,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // More oval shape
        border: Border.all(color: Colors.blue.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade800),
                          borderRadius: BorderRadius.circular(20), // More oval shape
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDate(_fromDate),
                              style: const TextStyle(fontSize: 16),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.blue.shade800,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade800),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDate(_toDate),
                              style: const TextStyle(fontSize: 16),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.blue.shade800,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, Widget field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: field,
          ),
          Positioned(
            left: 10,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.grey.shade50,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String? hintText, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // More oval shape
        borderSide: BorderSide(color: Colors.blue.shade800),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // More oval shape
        borderSide: BorderSide(color: Colors.blue.shade800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // More oval shape
        borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
      ),
      // Remove any default label styling
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }
}