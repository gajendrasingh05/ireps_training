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
        primaryColor: Colors.blue[800],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue[800]!,
          primary: Colors.blue[800]!,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
      home: const POSearchPage(),
    );
  }
}

class POSearchPage extends StatefulWidget {
  const POSearchPage({Key? key}) : super(key: key);

  @override
  State<POSearchPage> createState() => _POSearchPageState();
}

class _POSearchPageState extends State<POSearchPage> {
  // Class variables
  final dateFromController = TextEditingController(text: '03-02-2025');
  final dateToController = TextEditingController(text: '06-05-2025');

  // Selection state variables
  String selectedStockOption = 'Both';
  String selectedLogicOperator = 'OR';

  // Variables for filter button dropdowns
  bool showPOPlacingAuthorityDropdown = false;
  bool showPurchaseSectionDropdown = false;
  bool showCoverageStatusDropdown = false;
  bool showTenderTypeDropdown = false;
  bool showInspectionAgencyDropdown = false;
  bool showIndustryTypeDropdown = false;
  bool showPOTypeDropdown = false;
  bool showPOValueDropdown = false;

  @override
  Widget build(BuildContext context) {
    // Define the blue color for calendar components
    final calendarBlue = Colors.blue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: const Text(
          'PO Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
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
      body: Container(
        color: Colors.grey[50],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Railway Dropdown
              _buildFloatingLabelDropdown(
                label: 'Railway',
                value: 'IREPS-TESTING',
                items: ['IREPS-TESTING'],
                onChanged: (value) {},
                hintText: 'Select Railway',
              ),

              // Enhanced Stock/Non-Stock selection with selectable toggle buttons
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2, bottom: 8),
                      child: Text(
                        'Stock/Non-Stock',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.blue[300]!),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _buildToggleButton(
                            label: 'Stock',
                            isSelected: selectedStockOption == 'Stock',
                            onTap: () {
                              setState(() {
                                selectedStockOption = 'Stock';
                              });
                            },
                          ),
                          _buildToggleButton(
                            label: 'Non-Stock',
                            isSelected: selectedStockOption == 'Non-Stock',
                            onTap: () {
                              setState(() {
                                selectedStockOption = 'Non-Stock';
                              });
                            },
                          ),
                          _buildToggleButton(
                            label: 'Both',
                            isSelected: selectedStockOption == 'Both',
                            onTap: () {
                              setState(() {
                                selectedStockOption = 'Both';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              _buildFloatingLabelDropdown(
                label: 'Department',
                value: 'Mechanical',
                items: ['Mechanical'],
                onChanged: (value) {},
                hintText: 'Select Department',
              ),

              _buildFloatingLabelDropdown(
                label: 'User Depot',
                value: '36640-SSE-I/PS/NDLS',
                items: ['36640-SSE-I/PS/NDLS'],
                onChanged: (value) {},
                hintText: 'Select User Depot',
              ),

              _buildFloatingLabelTextField(
                label: 'Item Description',
                hintText: 'Enter Item Description',
              ),

              // Logic Operator toggle buttons
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.blue[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _buildToggleButton(
                        label: 'OR',
                        isSelected: selectedLogicOperator == 'OR',
                        onTap: () {
                          setState(() {
                            selectedLogicOperator = 'OR';
                          });
                        },
                      ),
                      _buildToggleButton(
                        label: 'AND',
                        isSelected: selectedLogicOperator == 'AND',
                        onTap: () {
                          setState(() {
                            selectedLogicOperator = 'AND';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              _buildFloatingLabelTextField(
                label: '',
                hintText: '',
              ),

              _buildFloatingLabelDropdown(
                label: 'User Sub Depot',
                value: null,
                items: ['Select User Sub Depot'],
                onChanged: (value) {},
                hintText: 'Select User Sub Depot',
              ),

              _buildFloatingLabelTextField(
                label: 'PO No.',
                hintText: 'Enter PO Number',
              ),

              _buildFloatingLabelTextField(
                label: 'Vendor Name',
                hintText: 'Enter Vendor Name',
              ),

              // Calendar Section with Blue Icons and Borders
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Purchase Order Date',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2, bottom: 4),
                                child: Text(
                                  'From',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // Updated border color to blue
                                  border: Border.all(color: calendarBlue),
                                ),
                                child: TextField(
                                  controller: dateFromController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    border: InputBorder.none,
                                    // Updated calendar icon color to blue
                                    suffixIcon: Icon(Icons.calendar_today, size: 18, color: calendarBlue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2, bottom: 4),
                                child: Text(
                                  'To',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // Updated border color to blue
                                  border: Border.all(color: calendarBlue),
                                ),
                                child: TextField(
                                  controller: dateToController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    border: InputBorder.none,
                                    // Updated calendar icon color to blue
                                    suffixIcon: Icon(Icons.calendar_today, size: 18, color: calendarBlue),
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
              const SizedBox(height: 10),

              // Filter Options Section (Updated styling to match the image but keeping original functionality)
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 5),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Additional Filters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),

                    // Updated filter buttons with new styling but preserving original functionality
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildUpdatedFilterButton(
                          label: 'Item Type',
                          onTap: () {},
                        ),
                        _buildUpdatedFilterButton(
                          label: 'Item Usage',
                          onTap: () {},
                        ),
                        _buildUpdatedFilterButton(
                          label: 'Item Category',
                          onTap: () {},
                        ),
                        _buildUpdatedFilterButton(
                          label: 'Stock/Non-Stock',
                          onTap: () {
                            setState(() {
                              selectedStockOption = selectedStockOption == 'Both' ? 'Stock' :
                              selectedStockOption == 'Stock' ? 'Non-Stock' : 'Both';
                            });
                          },
                        ),
                        _buildUpdatedFilterButton(
                          label: 'PO Placing Authority',
                          onTap: () {
                            setState(() {
                              showPOPlacingAuthorityDropdown = !showPOPlacingAuthorityDropdown;
                            });
                          },
                        ),
                        _buildUpdatedFilterButton(
                          label: 'Purchase Section',
                          onTap: () {
                            setState(() {
                              showPurchaseSectionDropdown = !showPurchaseSectionDropdown;
                            });
                          },
                        ),
                        _buildUpdatedFilterButton(
                          label: 'Coverage Status',
                          onTap: () {
                            setState(() {
                              showCoverageStatusDropdown = !showCoverageStatusDropdown;
                            });
                          },
                        ),
                        _buildUpdatedFilterButton(
                          label: 'Tender Type',
                          onTap: () {
                            setState(() {
                              showTenderTypeDropdown = !showTenderTypeDropdown;
                            });
                          },
                        ),
                        _buildUpdatedFilterButton(
                          label: 'Inspection Agency',
                          onTap: () {
                            setState(() {
                              showInspectionAgencyDropdown = !showInspectionAgencyDropdown;
                            });
                          },
                        ),
                        _buildUpdatedFilterButton(
                          label: 'Industry Type',
                          onTap: () {
                            setState(() {
                              showIndustryTypeDropdown = !showIndustryTypeDropdown;
                            });
                          },
                        ),
                        _buildUpdatedFilterButton(
                          label: 'PO Type',
                          onTap: () {
                            setState(() {
                              showPOTypeDropdown = !showPOTypeDropdown;
                            });
                          },
                        ),
                        _buildUpdatedFilterButton(
                          label: 'PO Value',
                          onTap: () {
                            setState(() {
                              showPOValueDropdown = !showPOValueDropdown;
                            });
                          },
                        ),
                      ],
                    ),

                    // Conditionally show dropdowns based on toggle state (keep the original functionality)
                    if (showPOPlacingAuthorityDropdown)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildFloatingLabelDropdown(
                          label: 'PO Placing Authority',
                          value: null,
                          items: ['Authority 1', 'Authority 2'],
                          onChanged: (value) {},
                          hintText: 'Select Authority',
                        ),
                      ),

                    if (showPurchaseSectionDropdown)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildFloatingLabelDropdown(
                          label: 'Purchase Section',
                          value: null,
                          items: ['Section 1', 'Section 2'],
                          onChanged: (value) {},
                          hintText: 'Select Section',
                        ),
                      ),

                    if (showCoverageStatusDropdown)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildFloatingLabelDropdown(
                          label: 'Coverage Status',
                          value: null,
                          items: ['Covered', 'Not Covered'],
                          onChanged: (value) {},
                          hintText: 'Select Status',
                        ),
                      ),

                    if (showTenderTypeDropdown)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildFloatingLabelDropdown(
                          label: 'Tender Type',
                          value: null,
                          items: ['Open', 'Limited', 'Single'],
                          onChanged: (value) {},
                          hintText: 'Select Type',
                        ),
                      ),

                    if (showInspectionAgencyDropdown)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildFloatingLabelDropdown(
                          label: 'Inspection Agency',
                          value: null,
                          items: ['Agency 1', 'Agency 2'],
                          onChanged: (value) {},
                          hintText: 'Select Agency',
                        ),
                      ),

                    if (showIndustryTypeDropdown)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildFloatingLabelDropdown(
                          label: 'Industry Type',
                          value: null,
                          items: ['Type 1', 'Type 2'],
                          onChanged: (value) {},
                          hintText: 'Select Type',
                        ),
                      ),

                    if (showPOTypeDropdown)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildFloatingLabelDropdown(
                          label: 'PO Type',
                          value: null,
                          items: ['Regular', 'Emergency'],
                          onChanged: (value) {},
                          hintText: 'Select Type',
                        ),
                      ),

                    if (showPOValueDropdown)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildFloatingLabelDropdown(
                          label: 'PO Value',
                          value: null,
                          items: ['< 1 Lakh', '1-10 Lakh', '> 10 Lakh'],
                          onChanged: (value) {},
                          hintText: 'Select Value Range',
                        ),
                      ),
                  ],
                ),
              ),

              // Get Details and Reset Buttons
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue[800]!, Colors.blue[600]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: const Center(
                              child: Text(
                                'Get Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue[800]!),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // New method to build updated filter buttons that match the image
  Widget _buildUpdatedFilterButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.blue[300]!),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods for floating label fields
  Widget _buildFloatingLabelDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required String hintText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: label.isEmpty ? 0 : 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue[300]!),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                hint: Text(hintText),
                icon: const Icon(Icons.keyboard_arrow_down),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                items: items.map((String itemValue) {
                  return DropdownMenuItem<String>(
                    value: itemValue,
                    child: Text(itemValue),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
          if (label.isNotEmpty)
            Positioned(
              left: 10,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                color: Colors.white,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingLabelTextField({
    required String label,
    required String hintText,
    TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: label.isEmpty ? 0 : 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue[300]!),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
              ),
            ),
          ),
          if (label.isNotEmpty)
            Positioned(
              left: 10,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                color: Colors.white,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Method for toggle buttons
  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[800] : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue[800],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterButton {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  FilterButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}
