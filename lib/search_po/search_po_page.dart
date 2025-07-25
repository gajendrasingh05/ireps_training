import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../purchase_order_results.dart';

class SearchPOPage extends StatefulWidget {
  const SearchPOPage({Key? key}) : super(key: key);

  @override
  State<SearchPOPage> createState() => _SearchPOPageState();
}

class _SearchPOPageState extends State<SearchPOPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _supplierController = TextEditingController();
  final TextEditingController _plNumberController = TextEditingController();
  final TextEditingController _minValueController = TextEditingController(text: '1');
  final TextEditingController _maxValueController = TextEditingController(text: '100');
  final TextEditingController _searchRailwayController = TextEditingController();

  String? _selectedRailway;
  bool _isRailwayDropdownOpen = false;

  final List<String> _railwayOptions = [
    'All', 'North Central Railway', 'North East Frontier Railway', 'North Western Railway',
    'Northern Railway', 'Patiala Locomotive Works', 'RDSO', 'Railway Board', 'South Central Railway',
    'South Eastern Railway', 'South Western Railway', 'Southern Railway', 'Western Railway'
  ];

  RangeValues _poRange = const RangeValues(1, 100);
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _startDate = DateTime.now().subtract(const Duration(days: 30));
    _endDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime initialDate = isStart ? _startDate! : _endDate!;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Widget _buildRailwayDropdown() {
    List<String> filteredOptions = _railwayOptions
        .where((option) => option.toLowerCase().contains(_searchRailwayController.text.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isRailwayDropdownOpen = !_isRailwayDropdownOpen),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Select Railway',
              prefixIcon: const Icon(Icons.train, color: Colors.blue),
              suffixIcon: Icon(_isRailwayDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: Colors.blue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              filled: true,
              fillColor: Colors.blue[50],
            ),
            child: Text(_selectedRailway ?? 'Select Railway'),
          ),
        ),
        if (_isRailwayDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchRailwayController,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView(
                      children: filteredOptions.map((railway) {
                        return ListTile(
                          title: Text(railway),
                          onTap: () {
                            setState(() {
                              _selectedRailway = railway;
                              _isRailwayDropdownOpen = false;
                              _searchRailwayController.clear();
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPOValueRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("PO Value Range (in Lakhs)", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const Text("Min Value (L):"),
                    const SizedBox(width: 6),
                    Container(
                      width: 70,
                      height: 36,
                      child: TextField(
                        controller: _minValueController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (val) {
                          final min = double.tryParse(val) ?? _poRange.start;
                          final max = _poRange.end;
                          if (min <= max) {
                            setState(() => _poRange = RangeValues(min, max));
                          }
                        },
                      ),
                    ),
                  ]),
                  Row(children: [
                    const Text("Max Value (L):"),
                    const SizedBox(width: 6),
                    Container(
                      width: 70,
                      height: 36,
                      child: TextField(
                        controller: _maxValueController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (val) {
                          final max = double.tryParse(val) ?? _poRange.end;
                          final min = _poRange.start;
                          if (min <= max) {
                            setState(() => _poRange = RangeValues(min, max));
                          }
                        },
                      ),
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 24),
              RangeSlider(
                values: _poRange,
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: Colors.blue[300],
                labels: RangeLabels('${_poRange.start.round()} L', '${_poRange.end.round()} L'),
                onChanged: (values) {
                  setState(() {
                    _poRange = values;
                    _minValueController.text = values.start.round().toString();
                    _maxValueController.text = values.end.round().toString();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildZonalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(label: 'Supplier Name', icon: Icons.apartment, controller: _supplierController),
          const SizedBox(height: 16),
          _buildTextField(label: 'PL Number', icon: Icons.tag, controller: _plNumberController, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildRailwayDropdown(),
          const SizedBox(height: 20),
          _buildPOValueRange(),
          const SizedBox(height: 24),
          const Text("Date Range (30 days difference required)", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, true),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Start Date",
                      prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    child: Text(DateFormat('dd/MM/yyyy').format(_startDate!)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, false),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "End Date",
                      prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    child: Text(DateFormat('dd/MM/yyyy').format(_endDate!)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to the results page without resetting form values
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PurchaseOrderResultsPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.blue[900],
            ),
            child: const Text("Show Results", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _supplierController.clear();
                _plNumberController.clear();
                _minValueController.text = '1';
                _maxValueController.text = '100';
                _poRange = const RangeValues(1, 100);
                _selectedRailway = null;
                _searchRailwayController.clear();
                _startDate = DateTime.now().subtract(const Duration(days: 30));
                _endDate = DateTime.now();
              });
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              side: const BorderSide(color: Colors.blue),
            ),
            child: const Text("Reset", style: TextStyle(fontSize: 16, color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required IconData icon, required TextEditingController controller, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.blue[50],
      ),
    );
  }

  Widget _buildOtherTab() {
    final List<String> otherRailways = [
      "BLW - Varanasi", "ICF - Perambur", "RCF - Kapurthala",
      "MCF - Raebareli", "CLW - Chittaranjan", "DMW - Patiala",
      "RWF - Bangalore", "CORE - Allahabad",
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Text(
              "Other Zonal Railways",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
          ),
          const SizedBox(height: 16),
          ...otherRailways.map((zone) => Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.blue[50],
                side: const BorderSide(color: Colors.blue),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(zone, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        leading: const BackButton(),
        title: const Text("Search PO"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.blue[800],
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(text: "Search PO (Zonal)"),
                Tab(text: "Search PO (Other)"),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildZonalTab(), _buildOtherTab()],
      ),
    );
  }
}
