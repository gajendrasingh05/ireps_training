import 'package:flutter/material.dart';

// Add this class at the top of your file
class DropdownSearch<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemAsString;
  final ValueChanged<T?> onChanged;
  final String? hintText;
  final String? labelText;
  final bool showSearchBox;
  final Widget? prefixIcon;
  final InputDecoration? searchBoxDecoration;
  final OutlineInputBorder? dropdownSearchDecoration;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  const DropdownSearch({
    Key? key,
    required this.items,
    this.selectedItem,
    required this.itemAsString,
    required this.onChanged,
    this.hintText,
    this.labelText,
    this.showSearchBox = true,
    this.prefixIcon,
    this.searchBoxDecoration,
    this.dropdownSearchDecoration,
    this.borderRadius = 20.0,
    this.borderColor = Colors.blue,
    this.borderWidth = 1.5,
  }) : super(key: key);

  @override
  State<DropdownSearch<T>> createState() => _DropdownSearchState<T>();
}

class _DropdownSearchState<T> extends State<DropdownSearch<T>> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(widget.items);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isDropdownOpen) {
        _closeDropdown();
      }
    });
  }

  @override
  void didUpdateWidget(covariant DropdownSearch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filteredItems = List.from(widget.items);
    }
  }

  @override
  void dispose() {
    _closeDropdown();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = List.from(widget.items);
      });
    } else {
      setState(() {
        _filteredItems = widget.items
            .where((item) => widget
            .itemAsString(item)
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
      });
    }

    // Rebuild the overlay with the updated filtered items
    _updateOverlay();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _focusNode.requestFocus();
    _isDropdownOpen = true;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {});
  }

  void _closeDropdown() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    _isDropdownOpen = false;
    _searchController.clear();
    _filteredItems = List.from(widget.items);
    setState(() {});
  }

  void _updateOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 300,
                  minWidth: size.width,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: widget.borderColor,
                    width: widget.borderWidth,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showSearchBox)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: widget.searchBoxDecoration ??
                              InputDecoration(
                                hintText: 'Search...',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.blue.shade800,
                                  size: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade800,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade800,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade800,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                          onChanged: _filterItems,
                        ),
                      ),
                    Divider(
                      height: 1,
                      thickness: 1.5,
                      color: Colors.blue.shade100,
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              widget.onChanged(_filteredItems[index]);
                              _closeDropdown();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Text(
                                widget.itemAsString(_filteredItems[index]),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
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
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null) widget.prefixIcon!,
              Expanded(
                child: Text(
                  widget.selectedItem != null
                      ? widget.itemAsString(widget.selectedItem!)
                      : widget.hintText ?? 'Select an item',
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.selectedItem != null
                        ? Colors.black
                        : Colors.grey.shade600,
                    fontWeight: FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.blue.shade800,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

  DateTime _fromDate = DateTime(2024, 6, 11);
  DateTime _toDate = DateTime(2025, 5, 5);

  String _statusValue = 'All';
  String _indentorValue = 'All';
  String _consigneeValue = 'All';

  // Full lists of options
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
    super.dispose();
  }

  // Filter methods
  void _filterStatusOptions() {
    if (_statusSearchController.text.isEmpty) {
      setState(() {
        _filteredStatusOptions = List.from(_statusOptions);
      });
    } else {
      setState(() {
        _filteredStatusOptions = _statusOptions
            .where((option) => option.toLowerCase().contains(_statusSearchController.text.toLowerCase()))
            .toList();
      });
    }
  }

  void _filterIndentorOptions() {
    if (_indentorSearchController.text.isEmpty) {
      setState(() {
        _filteredIndentorOptions = List.from(_indentorOptions);
      });
    } else {
      setState(() {
        _filteredIndentorOptions = _indentorOptions
            .where((option) => option.toLowerCase().contains(_indentorSearchController.text.toLowerCase()))
            .toList();
      });
    }
  }

  void _filterConsigneeOptions() {
    if (_consigneeSearchController.text.isEmpty) {
      setState(() {
        _filteredConsigneeOptions = List.from(_consigneeOptions);
      });
    } else {
      setState(() {
        _filteredConsigneeOptions = _consigneeOptions
            .where((option) => option.toLowerCase().contains(_consigneeSearchController.text.toLowerCase()))
            .toList();
      });
    }
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
          // Status Dropdown
          _buildFormField(
            'Status',
            DropdownSearch<String>(
              items: _statusOptions,
              selectedItem: _statusValue,
              itemAsString: (item) => item,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _statusValue = value;
                  });
                }
              },
              borderColor: Colors.blue.shade800,
              borderRadius: 20,
              borderWidth: 1.5,
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

          // Indentor Dropdown
          _buildFormField(
            'Indentor',
            DropdownSearch<String>(
              items: _indentorOptions,
              selectedItem: _indentorValue,
              itemAsString: (item) => item,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _indentorValue = value;
                  });
                }
              },
              borderColor: Colors.blue.shade800,
              borderRadius: 20,
              borderWidth: 1.5,
            ),
          ),

          // Consignee Dropdown
          _buildFormField(
            'Consignee',
            DropdownSearch<String>(
              items: _consigneeOptions,
              selectedItem: _consigneeValue,
              itemAsString: (item) => item,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _consigneeValue = value;
                  });
                }
              },
              borderColor: Colors.blue.shade800,
              borderRadius: 20,
              borderWidth: 1.5,
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

  // New searchable dropdown widget
  Widget _buildSearchableDropdown({
    required String value,
    required TextEditingController searchController,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
          ),
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : items.isNotEmpty ? items[0] : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade800, size: 28),
        isExpanded: true,
        dropdownColor: Colors.white,
        menuMaxHeight: 300,
        selectedItemBuilder: (BuildContext context) {
          return items.map<Widget>((String item) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          }).toList();
        },
        items: [
          DropdownMenuItem<String>(
            value: null,
            enabled: false,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      prefixIcon: Icon(Icons.search, color: Colors.blue.shade800, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onTap: () {
                      // Prevent the dropdown from closing when the text field is tapped
                      // This is handled by passing the GestureTapCallback to the onTap parameter
                    },
                  ),
                ),
                Divider(height: 1, thickness: 1.5, color: Colors.blue.shade100),
              ],
            ),
          ),
          ...items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ],
        onChanged: onChanged,
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