//*** path ***
//User Depot Module >> Summary of Stock >>

import 'package:flutter/material.dart';
import 'user_depot_stock_summary.dart';
import 'submit_summary_of_stocks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Summary of Stock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.grey.shade50,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
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
            borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
          ),
        ),
      ),
      home: const SummaryOfStocksScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SummaryOfStocksScreen extends StatefulWidget {
  const SummaryOfStocksScreen({super.key});

  @override
  State<SummaryOfStocksScreen> createState() => _SummaryOfStocksScreenState();
}

class _SummaryOfStocksScreenState extends State<SummaryOfStocksScreen> {
  String? selectedRailway;
  String? selectedUnitType;
  String? selectedUnitName;
  String? selectedDepartment;
  String? selectedUserDepot;
  String? selectedUserSubDepot;
  String? selectedItemType;
  String? selectedItemUsage;
  String? selectedItemCategory;
  String? selectedStockNonStock;

  bool isItemTypeSelected = false;
  bool isItemUsageSelected = false;
  bool isItemCategorySelected = false;
  bool isStockNonStockSelected = false;

  final List<String> railways = [
    'Banaras Locomotive Works',
    'COFMOW',
    'CORE',
    'Central Railway',
    'East Central',
    'East Coast Railway',
  ];

  final List<String> unitTypes = ['All', 'Division', 'Zonal HQ / PU HQ'];

  final List<String> unitNames = ['All', 'EPS HQ', 'EPS/UD'];

  final List<String> departments = [
    'All',
    'Accounts',
    'Administration',
    'Commercial',
    'Electrical',
    'Engineering',
  ];

  final List<String> userDepots = [
    'SSE/EPS/UD',
    'SSE/ELE/UD',
    'SSE/CIV/UD',
    'SSE/SIG/UD',
    'SSE/STO/UD',
  ];

  final List<String> userSubDepots = ['OO-SSE/EPS/UD', 'All'];

  final List<String> itemTypes = ['All', 'Vital', 'Safety', 'Others'];

  final List<String> itemUsages = [
    'Any',
    'Consumable',
    'M and P',
    'M and P Spares',
    'T and P',
  ];

  final List<String> itemCategories = [
    'All',
    'Ordinary New Stores',
    'Second Hand Stores',
    'Repairable Stores',
    'Movable Surplus',
    'Dead Surplus',
  ];

  final List<String> stockNonStock = [
    'All items',
    'Stock (Items having PL No.)',
    'Non-Stock (Items not having PL No.)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary of Stock',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row 1: Railway and Unit Type
                    Row(
                      children: [
                        Expanded(
                          child: _buildLabeledDropdown(
                            label: 'Railway',
                            hint: 'Select Railway',
                            value: selectedRailway,
                            items: railways,
                            onChanged: (String? value) {
                              setState(() {
                                selectedRailway = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildLabeledDropdown(
                            label: 'Unit Type',
                            hint: 'Select Unit Type',
                            value: selectedUnitType,
                            items: unitTypes,
                            onChanged: (String? value) {
                              setState(() {
                                selectedUnitType = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Row 2: Unit Name and Department
                    Row(
                      children: [
                        Expanded(
                          child: _buildLabeledDropdown(
                            label: 'Unit Name',
                            hint: 'Select Unit Name',
                            value: selectedUnitName,
                            items: unitNames,
                            onChanged: (String? value) {
                              setState(() {
                                selectedUnitName = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildLabeledDropdown(
                            label: 'Department',
                            hint: 'Select Department',
                            value: selectedDepartment,
                            items: departments,
                            onChanged: (String? value) {
                              setState(() {
                                selectedDepartment = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Row 3: User Depot
                    Row(
                      children: [
                        Expanded(
                          child: _buildLabeledDropdown(
                            label: 'User Depot',
                            hint: 'Select User Depot',
                            value: selectedUserDepot,
                            items: userDepots,
                            onChanged: (String? value) {
                              setState(() {
                                selectedUserDepot = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Row 4: User Sub Depot
                    Row(
                      children: [
                        Expanded(
                          child: _buildLabeledDropdown(
                            label: 'User Sub Depot',
                            hint: 'Select User Sub Depot',
                            value: selectedUserSubDepot,
                            items: userSubDepots,
                            onChanged: (String? value) {
                              setState(() {
                                selectedUserSubDepot = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Item Selection Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Toggle Buttons for Item Selection
                    Row(
                      children: [
                        Expanded(
                          child: _buildToggleButton(
                            'Item Type',
                            isItemTypeSelected,
                            () {
                              setState(() {
                                isItemTypeSelected = !isItemTypeSelected;
                                if (!isItemTypeSelected) {
                                  selectedItemType = null;
                                }
                              });
                            },
                            selectedIcon: Icons.category,
                            unselectedIcon: Icons.category_outlined,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildToggleButton(
                            'Item Usage',
                            isItemUsageSelected,
                            () {
                              setState(() {
                                isItemUsageSelected = !isItemUsageSelected;
                                if (!isItemUsageSelected) {
                                  selectedItemUsage = null;
                                }
                              });
                            },
                            selectedIcon: Icons.build,
                            unselectedIcon: Icons.build_outlined,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildToggleButton(
                            'Item Category',
                            isItemCategorySelected,
                            () {
                              setState(() {
                                isItemCategorySelected =
                                    !isItemCategorySelected;
                                if (!isItemCategorySelected) {
                                  selectedItemCategory = null;
                                }
                              });
                            },
                            selectedIcon: Icons.class_,
                            unselectedIcon: Icons.class_outlined,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildToggleButton(
                            'Stock/Non-Stock',
                            isStockNonStockSelected,
                            () {
                              setState(() {
                                isStockNonStockSelected =
                                    !isStockNonStockSelected;
                                if (!isStockNonStockSelected) {
                                  selectedStockNonStock = null;
                                }
                              });
                            },
                            selectedIcon: Icons.inventory,
                            unselectedIcon: Icons.inventory_outlined,
                          ),
                        ),
                      ],
                    ),
                    // Sub-dropdowns for selected items
                    if (isItemTypeSelected) ...[
                      const SizedBox(height: 16),
                      _buildSubDropdown(
                        'Item Type',
                        selectedItemType,
                        itemTypes,
                        (String? value) {
                          setState(() {
                            selectedItemType = value;
                          });
                        },
                      ),
                    ],

                    if (isItemUsageSelected) ...[
                      const SizedBox(height: 16),
                      _buildSubDropdown(
                        'Item Usage',
                        selectedItemUsage,
                        itemUsages,
                        (String? value) {
                          setState(() {
                            selectedItemUsage = value;
                          });
                        },
                      ),
                    ],

                    if (isItemCategorySelected) ...[
                      const SizedBox(height: 16),
                      _buildSubDropdown(
                        'Item Category',
                        selectedItemCategory,
                        itemCategories,
                        (String? value) {
                          setState(() {
                            selectedItemCategory = value;
                          });
                        },
                      ),
                    ],

                    if (isStockNonStockSelected) ...[
                      const SizedBox(height: 16),
                      _buildSubDropdown(
                        'Stock/Non-Stock',
                        selectedStockNonStock,
                        stockNonStock,
                        (String? value) {
                          setState(() {
                            selectedStockNonStock = value;
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Action Buttons Card
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _resetSelections();
                          },
                          icon: const Icon(Icons.restart_alt_rounded),
                          label: const Text('Reset All'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade50,
                            foregroundColor: Colors.blue.shade500,
                            side: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.5,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 2,
                            shadowColor: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _submitQuery();
                          },
                          icon: const Icon(Icons.assignment_turned_in),
                          label: const Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Summary Button
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showSummary();
                      },
                      icon: const Icon(Icons.analytics_outlined),
                      label: const Text('Generate Summary'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade500,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildLabeledDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 2),
        DropdownMenu<String>(
          width: double.infinity,
          hintText: hint,
          requestFocusOnTap: true,
          enableFilter: true,
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
            ),
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey.shade50),
            elevation: WidgetStateProperty.all(8),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 8),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((
            String item,
          ) {
            return DropdownMenuEntry<String>(
              value: item,
              label: item,
              style: MenuItemButton.styleFrom(
                foregroundColor: Colors.blue.shade800,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onSelected: (String? selectedValue) {
            onChanged(selectedValue);
          },
          initialSelection: value,
        ),
      ],
    );
  }

  Widget _buildToggleButton(
    String text,
    bool isSelected,
    VoidCallback onPressed, {
    required IconData selectedIcon,
    required IconData unselectedIcon,
  }) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.blue.shade200,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Colors.blue.shade500
              : Colors.blue.shade50,
          foregroundColor: isSelected ? Colors.white : Colors.blue.shade800,
          elevation: isSelected ? 2 : 0,
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              size: 16,
              color: isSelected ? Colors.white : Colors.blue.shade800,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubDropdown(
    String hint,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: DropdownMenu<String>(
        width: double.infinity,
        hintText: hint,
        requestFocusOnTap: true,
        enableFilter: true,
        leadingIcon: Icon(Icons.filter_list, color: Colors.grey, size: 18),
        textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade100, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade100, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade500, width: 2),
          ),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          elevation: WidgetStateProperty.all(6),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 6),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.blue.shade100, width: 0.5),
            ),
          ),
        ),
        dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((
          String item,
        ) {
          return DropdownMenuEntry<String>(
            value: item,
            label: item,
            style: MenuItemButton.styleFrom(
              foregroundColor: Colors.blue.shade800,
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
        onSelected: (String? selectedValue) {
          onChanged(selectedValue);
        },
        initialSelection: value,
      ),
    );
  }

  void _resetSelections() {
    setState(() {
      selectedRailway = null;
      selectedUnitType = null;
      selectedUnitName = null;
      selectedDepartment = null;
      selectedUserDepot = null;
      selectedUserSubDepot = null;
      selectedItemType = null;
      selectedItemUsage = null;
      selectedItemCategory = null;
      selectedStockNonStock = null;
      isItemTypeSelected = false;
      isItemUsageSelected = false;
      isItemCategorySelected = false;
      isStockNonStockSelected = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.blue.shade700,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'All selections have been reset successfully',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade50,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _submitQuery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SubmitSummaryofStocksScreen()),
    );
  }

  void _showSummary() {
    // Navigate to the User Depot Stock Summary screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserDepotStockSummaryScreen(),
      ),
    );
  }
}
