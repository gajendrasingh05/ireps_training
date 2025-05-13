import 'package:flutter/material.dart';

void main() {
  runApp(const WarrantyRejectionApp());
}

class WarrantyRejectionApp extends StatelessWidget {
  const WarrantyRejectionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warranty Rejection Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          elevation: 0,
          // Making text and icons white
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 0,
          ),
        ),
      ),
      home: const WarrantyRejectionRegisterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WarrantyRejectionRegisterScreen extends StatefulWidget {
  const WarrantyRejectionRegisterScreen({Key? key}) : super(key: key);

  @override
  State<WarrantyRejectionRegisterScreen> createState() => _WarrantyRejectionRegisterScreenState();
}

class _WarrantyRejectionRegisterScreenState extends State<WarrantyRejectionRegisterScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Controllers for dropdown search
  final TextEditingController _railwayController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _userDepotController = TextEditingController();
  final TextEditingController _subConsigneeController = TextEditingController();

  DateTime? startDate = DateTime(2024, 2, 11);
  DateTime? endDate = DateTime(2025, 5, 1);
  String transactionType = 'Warranty Rejection Register';
  String railway = 'IREPS-TESTING';
  String department = 'Mechanical';
  String userDepot = '36640-SSE-I/PS/NDLS';
  String subConsignee = '00-SSE/EPS/UD';
  String searchFilter = 'All';

  // Lists for dropdown options
  final List<String> railwayOptions = ['IREPS-TESTING', 'IREPS-PROD', 'NORTH-RAILWAY'];
  final List<String> departmentOptions = ['Mechanical', 'Electrical', 'Civil', 'Signal'];
  final List<String> userDepotOptions = ['36640-SSE-I/PS/NDLS', '36641-SSE-II/PS/NDLS', '36642-SSE-III/PS/NDLS'];
  final List<String> subConsigneeOptions = ['00-SSE/EPS/UD', '01-SSE/EPS/LD', '02-SSE/EPS/CD'];

  @override
  void initState() {
    super.initState();
    _railwayController.text = railway;
    _departmentController.text = department;
    _userDepotController.text = userDepot;
    _subConsigneeController.text = subConsignee;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _railwayController.dispose();
    _departmentController.dispose();
    _userDepotController.dispose();
    _subConsigneeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Warranty Rejection Register',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Range Section - Side by side layout
              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      label: 'Warranty Claim Period',
                      value: '02-11-2024',
                      onTap: () async {
                        final date = await _selectDate(context, startDate);
                        if (date != null) {
                          setState(() {
                            startDate = date;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDateField(
                      label: '',
                      value: '01-05-2025',
                      onTap: () async {
                        final date = await _selectDate(context, endDate);
                        if (date != null) {
                          setState(() {
                            endDate = date;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Transaction Type Section with toggle switch
              _buildSectionTitle('Transaction Type'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            transactionType = 'Rejection Advice Register';
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: transactionType == 'Rejection Advice Register'
                                ? Colors.blue.shade700
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'Rejection Advice',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: transactionType == 'Rejection Advice Register'
                                    ? Colors.white
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.blue.shade100,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            transactionType = 'Warranty Rejection Register';
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: transactionType == 'Warranty Rejection Register'
                                ? Colors.blue.shade700
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'Warranty Rejection',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: transactionType == 'Warranty Rejection Register'
                                    ? Colors.white
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Railway dropdown search
              _buildDropdownSearch(
                label: 'Railway',
                controller: _railwayController,
                options: railwayOptions,
                currentValue: railway,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      railway = value;
                      _railwayController.text = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Department dropdown search
              _buildDropdownSearch(
                label: 'Select Department',
                controller: _departmentController,
                options: departmentOptions,
                currentValue: department,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      department = value;
                      _departmentController.text = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // User Depot dropdown search
              _buildDropdownSearch(
                label: 'Select User Depot',
                controller: _userDepotController,
                options: userDepotOptions,
                currentValue: userDepot,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      userDepot = value;
                      _userDepotController.text = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Sub-Consignee dropdown search
              _buildDropdownSearch(
                label: 'Sub-Consignee',
                controller: _subConsigneeController,
                options: subConsigneeOptions,
                currentValue: subConsignee,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      subConsignee = value;
                      _subConsigneeController.text = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Unified Search Bar - now with label outside
              _buildSectionTitle('Search'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search by Vendor, Claim No, DMTR No, or Item Code',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.blue.shade700,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Filter Results with horizontal scrolling row
              _buildSectionTitle('Filter Results'),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildHorizontalFilterOption(
                        label: 'All',
                        icon: Icons.checklist,
                        isSelected: searchFilter == 'All',
                        onTap: () {
                          setState(() {
                            searchFilter = 'All';
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildHorizontalFilterOption(
                        label: 'Pending Recovery',
                        icon: Icons.pending_actions,
                        isSelected: searchFilter == 'Pending Recovery',
                        onTap: () {
                          setState(() {
                            searchFilter = 'Pending Recovery';
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildHorizontalFilterOption(
                        label: 'Nil Recovery',
                        icon: Icons.not_interested,
                        isSelected: searchFilter == 'Nil Recovery',
                        onTap: () {
                          setState(() {
                            searchFilter = 'Nil Recovery';
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildHorizontalFilterOption(
                        label: 'Material to be Returned',
                        icon: Icons.assignment_return,
                        isSelected: searchFilter == 'Material to be Returned',
                        onTap: () {
                          setState(() {
                            searchFilter = 'Material to be Returned';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons with smaller styling
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade800,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.blue.shade800),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Exit',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom dropdown search widget
  Widget _buildDropdownSearch({
    required String label,
    required TextEditingController controller,
    required List<String> options,
    required String currentValue,
    required Function(String?) onChanged,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: InkWell(
            onTap: () {
              _showSearchDropdown(context, options, currentValue, onChanged);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      currentValue,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade700, size: 24),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 18,
          top: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Method to show dropdown search dialog
  Future<void> _showSearchDropdown(
      BuildContext context,
      List<String> options,
      String currentValue,
      Function(String?) onChanged,
      ) async {
    final TextEditingController searchController = TextEditingController();
    List<String> filteredOptions = List.from(options);

    // Show a search dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Select Option',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search field
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue.shade100),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onChanged: (value) {
                        setState(() {
                          filteredOptions = options
                              .where((option) => option.toLowerCase().contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Options list
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredOptions.length,
                        itemBuilder: (context, index) {
                          final option = filteredOptions[index];
                          final isSelected = option == currentValue;

                          return ListTile(
                            title: Text(
                              option,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.blue.shade700 : Colors.black87,
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(Icons.check_circle, color: Colors.blue.shade700)
                                : null,
                            onTap: () {
                              onChanged(option);
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
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue.shade700),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
        );
      },
    );

    // Dispose of the controller
    searchController.dispose();
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.blue.shade700,
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Icon(Icons.calendar_today, size: 18, color: Colors.blue.shade700),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalFilterOption({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue.shade300 : Colors.grey.shade300,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.blue.shade700 : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context, DateTime? initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade700,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}