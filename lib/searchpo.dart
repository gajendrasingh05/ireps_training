import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PO Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const POSearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class POSearchScreen extends StatefulWidget {
  const POSearchScreen({Key? key}) : super(key: key);

  @override
  POSearchScreenState createState() => POSearchScreenState();
}

class POSearchScreenState extends State<POSearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _supplierController = TextEditingController();
  final TextEditingController _plNoController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  // Initialize with default values
  double _minValue = 0;
  double _maxValue = 100;

  String? _selectedRailway;

  final List<String> railways = [
    'Banaras Locomotive Works',
    'COFMOW',
    'CORE',
    'Chittaranjan Locomotive Works',
    'East Central Railway',
    'East Coast Railway',
    'Eastern Railway',
    'IREPS TESTING2',
    'IRICEN',
    'IRIEEN',
    'IRIFM',
    'IRIMEE',
    'IRISET',
    'IRITM',
    'IROAF',
    'Integral Coach Factory',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _supplierController.dispose();
    _plNoController.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _formKey.currentState?.reset();
      _supplierController.clear();
      _plNoController.clear();
      _startDate = null;
      _endDate = null;
      _minValue = 0;
      _maxValue = 100;
      _selectedRailway = null;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
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
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  Widget _buildTextFormField(TextEditingController controller, String label, String hint, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.blue.shade800),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade800),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade800),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
            hintStyle: const TextStyle(color: Colors.black54),
          ),
          style: const TextStyle(fontSize: 12, color: Colors.black),
          validator: (value) {
            if (value == null || value.length < 3) {
              return 'Minimum 3 characters required';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildRailwayDropdown() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
          value: _selectedRailway,
          decoration: InputDecoration(
            labelText: 'Select Railway',
            prefixIcon: Icon(Icons.train, color: Colors.blue.shade800),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade800),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade800),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
          ),
          style: const TextStyle(fontSize: 12, color: Colors.black),
          dropdownColor: Colors.white,
          items: railways.map((String railway) {
            return DropdownMenuItem<String>(
              value: railway,
              child: Text(railway, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedRailway = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPOValueRange() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'PO Value Range (in Lakhs)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '₹${_minValue.toStringAsFixed(0)} L - ₹${_maxValue.toStringAsFixed(0)} L',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: Colors.blue.shade800,
                      inactiveTrackColor: Colors.blue.shade100,
                      thumbColor: Colors.blue.shade800,
                      overlayColor: Colors.blue.shade800.withOpacity(0.2),
                      valueIndicatorColor: Colors.blue.shade800,
                      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                      showValueIndicator: ShowValueIndicator.always,
                    ),
                    child: RangeSlider(
                      values: RangeValues(_minValue, _maxValue),
                      min: 0,
                      max: 100,
                      divisions: 100,
                      labels: RangeLabels(
                        '₹${_minValue.round()} L',
                        '₹${_maxValue.round()} L',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _minValue = values.start;
                          _maxValue = values.end;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRange() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date Range (30 days difference required)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade800),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: OutlinedButton.icon(
                      onPressed: () => _selectDate(context, true),
                      icon: Icon(Icons.calendar_today, color: Colors.blue.shade800),
                      label: Text(
                        _startDate != null ? _formatDate(_startDate) : 'From',
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade800),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: OutlinedButton.icon(
                      onPressed: () => _selectDate(context, false),
                      icon: Icon(Icons.calendar_today, color: Colors.blue.shade800),
                      label: Text(
                        _endDate != null ? _formatDate(_endDate) : 'To',
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Center(
          child: Text(
            'Search PO',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Handle home button press
            },
          ),
        ],
        backgroundColor: Colors.blue.shade800,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Search PO (Zonal)'),
            Tab(text: 'Search PO (Other)'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontSize: 14),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextFormField(
                    _supplierController,
                    'Supplier Name',
                    'Min 3 characters required,Optional Field',
                    Icons.business,
                  ),
                  const SizedBox(height: 8),
                  _buildTextFormField(
                    _plNoController,
                    'PL Number',
                    'Min 3 characters required,Optional Field',
                    Icons.numbers,
                  ),
                  const SizedBox(height: 8),
                  _buildRailwayDropdown(),
                  const SizedBox(height: 8),
                  _buildPOValueRange(),
                  const SizedBox(height: 8),
                  _buildDateRange(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Search...')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Show Result',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: _resetForm,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.blue.shade800),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Center(
            child: Text(
                'Search PO (Other) - Coming Soon',
                style: TextStyle(fontSize: 14, color: Colors.black)
            ),
          ),
        ],
      ),
    );
  }
}