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
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue[800],
          secondary: Colors.blue[600],
        ),
      ),
      home: const TransactionsPage(),
    );
  }
}

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  // Add state variables for date selection
  DateTime fromDate = DateTime(2025, 1, 23);
  DateTime toDate = DateTime(2025, 4, 23);

  // Search controller
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // Dropdown search controller
  final TextEditingController dropdownSearchController = TextEditingController();

  // Initial values for form fields - used for reset functionality
  final String initialRailway = 'IREPS-TESTING';
  final String initialUnitType = 'Zonal HQ / PU HQ';
  final String initialUnitName = 'EPS/UD';
  final String initialDepartment = 'Mechanical';
  final String initialUserDepot = '36640-SR. SECTION ENGINEER-I/PS/NEW DELHI';
  final String initialUserSubDepot = '00-SSE/EPS/UD';
  final String initialLedgerNo = 'Ledger No.';
  final String initialFolioNo = 'Folio No.';
  final String initialLedgerFolioPlNo = 'Ledger Folio PL No.';
  final String initialSearchText = '';

  // Current values for form fields
  String railway = 'IREPS-TESTING';
  String unitType = 'Zonal HQ / PU HQ';
  String unitName = 'EPS/UD';
  String department = 'Mechanical';
  String userDepot = '36640-SR. SECTION ENGINEER-I/PS/NEW DELHI';
  String userSubDepot = '00-SSE/EPS/UD';
  String ledgerNo = 'Ledger No.';
  String folioNo = 'Folio No.';
  String ledgerFolioPlNo = 'Ledger Folio PL No.';
  String searchText = '';
  bool isSearchFocused = false;

  // Options for dropdowns
  final List<String> railwayOptions = [
    'IREPS-TESTING',
    'Northern Railway',
    'Southern Railway',
    'Eastern Railway',
    'Western Railway',
    'Central Railway'
  ];

  final List<String> unitTypeOptions = [
    'Zonal HQ / PU HQ',
    'Division',
    'Workshop',
    'Depot',
    'Project Unit'
  ];

  final List<String> unitNameOptions = [
    'EPS/UD',
    'NR/NDLS',
    'SR/MAS',
    'ER/HWH',
    'WR/BCT',
    'CR/CSTM'
  ];

  final List<String> departmentOptions = [
    'Mechanical',
    'Electrical',
    'Civil',
    'Signal & Telecom',
    'Medical',
    'Personnel',
    'Accounts'
  ];

  final List<String> userDepotOptions = [
    '36640-SR. SECTION ENGINEER-I/PS/NEW DELHI',
    '36641-SR. SECTION ENGINEER-II/PS/NEW DELHI',
    '36642-ASST. ENGINEER/PS/NEW DELHI',
    '36643-DIVISIONAL ENGINEER/PS/NEW DELHI',
    '36644-CHIEF ENGINEER/PS/NEW DELHI'
  ];

  final List<String> userSubDepotOptions = [
    '00-SSE/EPS/UD',
    '01-SSE/EPS/UD',
    '02-SSE/EPS/UD',
    '03-SSE/EPS/UD',
    '04-SSE/EPS/UD'
  ];

  final List<String> ledgerNoOptions = [
    'Ledger No.',
    'L001',
    'L002',
    'L003',
    'L004',
    'L005'
  ];

  final List<String> folioNoOptions = [
    'Folio No.',
    'F001',
    'F002',
    'F003',
    'F004',
    'F005'
  ];

  final List<String> ledgerFolioPlNoOptions = [
    'Ledger Folio PL No.',
    'LP001',
    'LP002',
    'LP003',
    'LP004',
    'LP005'
  ];

  @override
  void initState() {
    super.initState();
    // Add listener to focus node to track focus state
    searchFocusNode.addListener(() {
      setState(() {
        isSearchFocused = searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to prevent memory leaks
    searchController.dispose();
    searchFocusNode.dispose();
    dropdownSearchController.dispose();
    super.dispose();
  }

  // Reset all form fields to initial values
  void resetForm() {
    setState(() {
      searchController.clear();
      fromDate = DateTime(2025, 1, 23);
      toDate = DateTime(2025, 4, 23);
      railway = initialRailway;
      unitType = initialUnitType;
      unitName = initialUnitName;
      department = initialDepartment;
      userDepot = initialUserDepot;
      userSubDepot = initialUserSubDepot;
      ledgerNo = initialLedgerNo;
      folioNo = initialFolioNo;
      ledgerFolioPlNo = initialLedgerFolioPlNo;
      searchText = initialSearchText;
    });
  }

  // Navigate to search page
  void navigateToSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(initialSearchText: searchText),
      ),
    ).then((result) {
      if (result != null && result is String) {
        setState(() {
          searchText = result;
          searchController.text = result;
        });
      }
    });
  }

  // Format date to display format
  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  // Show date picker and update state
  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue[800],
            colorScheme: ColorScheme.light(primary: Colors.blue[800]!),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  // Method to show dropdown options with search functionality
  void _showSearchableDropdown(BuildContext context, String label, List<String> options, String currentValue) {
    // Clear search controller
    dropdownSearchController.clear();

    // Filtered options list - initially contains all options
    List<String> filteredOptions = List.from(options);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the modal to expand for keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder( // Use StatefulBuilder to update state within the modal
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6, // Set height to 60% of screen
                padding: const EdgeInsets.all(22), // Increased from 20
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select $label',
                      style: TextStyle(
                        fontSize: 22, // Increased from 20
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 22), // Increased from 20
                    // Search box for filtering options
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: TextField(
                        controller: dropdownSearchController,
                        decoration: InputDecoration(
                          hintText: 'Search $label',
                          prefixIcon: Icon(Icons.search, color: Colors.blue[700], size: 26), // Increased from 24
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        ),
                        style: const TextStyle(fontSize: 14), // Decreased from 16
                        onChanged: (value) {
                          // Filter options based on search text
                          setModalState(() {
                            filteredOptions = options.where((option) =>
                                option.toLowerCase().contains(value.toLowerCase())
                            ).toList();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 22), // Increased from 20
                    Expanded(
                      child: filteredOptions.isEmpty
                          ? Center(
                        child: Text(
                          'No matches found',
                          style: TextStyle(color: Colors.grey[600], fontSize: 14), // Decreased from 16
                        ),
                      )
                          : ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredOptions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              filteredOptions[index],
                              style: const TextStyle(fontSize: 14), // Decreased from 16
                            ),
                            selected: filteredOptions[index] == currentValue,
                            selectedTileColor: Colors.blue[50],
                            contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16), // Increased from 4
                            onTap: () {
                              setState(() {
                                switch (label) {
                                  case 'Railway':
                                    railway = filteredOptions[index];
                                    break;
                                  case 'Unit Type':
                                    unitType = filteredOptions[index];
                                    break;
                                  case 'Unit Name':
                                    unitName = filteredOptions[index];
                                    break;
                                  case 'Department':
                                    department = filteredOptions[index];
                                    break;
                                  case 'User Depot':
                                    userDepot = filteredOptions[index];
                                    break;
                                  case 'User Sub Depot':
                                    userSubDepot = filteredOptions[index];
                                    break;
                                  case 'Ledger No':
                                    ledgerNo = filteredOptions[index];
                                    break;
                                  case 'Folio No':
                                    folioNo = filteredOptions[index];
                                    break;
                                  case 'Ledger Folio PL No':
                                    ledgerFolioPlNo = filteredOptions[index];
                                    break;
                                }
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Close keyboard and remove focus when tapping outside of text fields
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          elevation: 0,
          titleSpacing: 0,
          title: const Text(
            'Transactions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24, // Increased from 22
              fontWeight: FontWeight.normal,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26), // Increased from 24
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 26), // Increased from 24
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0), // Increased from 16 & 14
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Railway Field
                _buildDropdownField('Railway', railway, railwayOptions),

                const SizedBox(height: 16), // Increased from 14
                // Unit Type Field
                _buildDropdownField('Unit Type', unitType, unitTypeOptions),

                const SizedBox(height: 16), // Increased from 14
                // Unit Name Field
                _buildDropdownField('Unit Name', unitName, unitNameOptions),

                const SizedBox(height: 16), // Increased from 14
                // Department Field
                _buildDropdownField('Department', department, departmentOptions),

                const SizedBox(height: 16), // Increased from 14
                // User Depot Field
                _buildDropdownField('User Depot', userDepot, userDepotOptions),

                const SizedBox(height: 16), // Increased from 14
                // User Sub Depot Field
                _buildDropdownField('User Sub Depot', userSubDepot, userSubDepotOptions),

                const SizedBox(height: 16), // Increased from 14
                // Enhanced Search Field moved below User Sub Depot
                GestureDetector(
                  onTap: navigateToSearchPage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(26.0), // Increased from 24
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    height: 58, // Increased from 54
                    margin: const EdgeInsets.only(bottom: 16.0), // Increased from 14
                    padding: const EdgeInsets.symmetric(horizontal: 18.0), // Increased from 16
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.blue[700], size: 26), // Increased from 24
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            searchText.isEmpty
                                ? 'Search PL No./Item Code/Folio Name/Description'
                                : searchText,
                            style: TextStyle(
                              fontSize: 13, // Decreased from 15
                              color: searchText.isEmpty ? Colors.grey[600] : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.blue[700], size: 20), // Increased from 18
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16), // Increased from 14
                // Ledger No Field
                _buildDropdownField('Ledger No', ledgerNo, ledgerNoOptions),

                const SizedBox(height: 16), // Increased from 14
                // Folio No Field
                _buildDropdownField('Folio No', folioNo, folioNoOptions),

                const SizedBox(height: 16), // Increased from 14
                // Ledger Folio PL No Field
                _buildDropdownField('Ledger Folio PL No', ledgerFolioPlNo, ledgerFolioPlNoOptions),

                const SizedBox(height: 18), // Increased from 16
                // Date Range Fields - reduced in size
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From Date',
                            style: TextStyle(
                              color: Colors.blue[600],
                              fontSize: 14, // Decreased from 16
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(18.0), // Increased from 16
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Decreased from 14, 18
                              height: 46, // Decreased from 52
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatDate(fromDate),
                                    style: const TextStyle(fontSize: 13), // Decreased from 15
                                  ),
                                  Icon(Icons.calendar_today, color: Colors.blue[700], size: 20), // Decreased from 22
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18), // Increased from 16
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To Date',
                            style: TextStyle(
                              color: Colors.blue[600],
                              fontSize: 14, // Decreased from 16
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(18.0), // Increased from 16
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Decreased from 14, 18
                              height: 46, // Decreased from 52
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatDate(toDate),
                                    style: const TextStyle(fontSize: 13), // Decreased from 15
                                  ),
                                  Icon(Icons.calendar_today, color: Colors.blue[700], size: 20), // Decreased from 22
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28), // Increased from 24
                // Button Row with larger buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildPrimaryButton('Get Details'),
                    ),
                    const SizedBox(width: 18), // Increased from 16
                    Expanded(
                      child: _buildOutlineButton('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> options) {
    return GestureDetector(
      onTap: () => _showSearchableDropdown(context, label, options, value),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12.0), // Increased from 10
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue[100]!),
              borderRadius: BorderRadius.circular(26.0), // Increased from 24
            ),
            child: ListTile(
              title: Text(
                value,
                style: const TextStyle(fontSize: 13), // Decreased from 15
              ),
              trailing: Icon(
                Icons.arrow_drop_down,
                color: Colors.blue[700],
                size: 26, // Increased from 24
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18.0), // Increased from 16
              dense: true,
              visualDensity: const VisualDensity(vertical: 0), // Increased from -2
              minLeadingWidth: 0,
              minVerticalPadding: 0,
            ),
          ),
          Positioned(
            top: 0,
            left: 18, // Increased from 16 to align with content padding
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              color: Colors.white,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 14, // Increased from 13
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(String text) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Getting details...'))
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased from 14
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0), // Increased from 24
        ),
        elevation: 1,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17, // Increased from 16
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOutlineButton(String text) {
    return OutlinedButton(
      onPressed: resetForm,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue[700],
        side: BorderSide(color: Colors.blue[700]!),
        padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased from 14
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0), // Increased from 24
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17, // Increased from 16
          fontWeight: FontWeight.bold,
          color: Colors.blue[700],
        ),
      ),
    );
  }
}

// New search page
class SearchPage extends StatefulWidget {
  final String initialSearchText;

  const SearchPage({Key? key, required this.initialSearchText}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<String> searchResults = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    searchController.text = widget.initialSearchText;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Method to fetch search results
  void fetchSearchResults() {
    if (searchController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter search text'))
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate API call with delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // Mock search results based on input text
        final String query = searchController.text.toLowerCase();
        searchResults = [
          '$query - Item 1',
          '$query - Item 2',
          '$query - Item 3',
          '$query - PL No. 12345',
          '$query - Folio Reference',
        ];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        titleSpacing: 0,
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24, // Increased from 22
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26), // Increased from 24
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0), // Increased from 16
        child: Column(
          children: [
            // Search input with fetch button
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(26.0), // Increased from 24
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(fontSize: 14), // Decreased from 16
                      decoration: InputDecoration(
                        hintText: 'Search PL No./Item Code/Folio Name/Description',
                        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14), // Decreased from 16
                        prefixIcon: Icon(Icons.search, color: Colors.blue[700], size: 26), // Increased from 24
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10), // Increased from 16, 8
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14), // Increased from 12
                ElevatedButton(
                  onPressed: fetchSearchResults,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22), // Increased from 16, 20
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0), // Increased from 24
                    ),
                  ),
                  child: const Text(
                    'Fetch',
                    style: TextStyle(
                      fontSize: 17, // Increased from 16
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28), // Increased from 24

            // Search results or loading indicator
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : searchResults.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64, // Increased from 60
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 18), // Increased from 16
                    Text(
                      'Enter search text and click Fetch',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15, // Decreased from 17
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      searchResults[index],
                      style: const TextStyle(fontSize: 14), // Decreased from 16
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18), // Increased from 8, 16
                    onTap: () {
                      // Return selected search result to previous page
                      Navigator.pop(context, searchResults[index]);
                    },
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20), // Increased size
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}