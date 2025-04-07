import 'package:flutter/material.dart';

void main() {
  runApp(RailwaySearchApp());
}

class RailwaySearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.blue.shade800),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue.shade300, width: 1),
          ),
        ),
      ),
      home: RailwaySearchScreen(),
    );
  }
}

class RailwaySearchScreen extends StatefulWidget {
  @override
  _RailwaySearchScreenState createState() => _RailwaySearchScreenState();
}

class _RailwaySearchScreenState extends State<RailwaySearchScreen> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown values with default selections
  String? selectedIreps = 'IREPS-TESTING';
  String? selectedUnitType = 'Zonal HQ / PU HQ';
  String? selectedUnitName = 'EPS/UD';
  String? selectedDepartment = 'Mechanical';
  String? selectedUserDepot = '36640-SR. SECTION ENGINEER-I/PS/';

  // Dropdown options
  final List<String> irepsOptions = ['IREPS-TESTING', 'IREPS-PRODUCTION'];
  final List<String> unitTypeOptions = ['Zonal HQ / PU HQ', 'Divisional HQ', 'Workshop'];
  final List<String> unitNameOptions = ['EPS/UD', 'Other Unit'];
  final List<String> departmentOptions = ['Mechanical', 'Electrical', 'Civil'];
  final List<String> userDepotOptions = [
    '36640-SR. SECTION ENGINEER-I/PS/',
    'Other Depot'
  ];

  void _resetForm() {
    setState(() {
      selectedIreps = 'IREPS-TESTING';
      selectedUnitType = 'Zonal HQ / PU HQ';
      selectedUnitName = 'EPS/UD';
      selectedDepartment = 'Mechanical';
      selectedUserDepot = '36640-SR. SECTION ENGINEER-I/PS/';
      _formKey.currentState?.reset();
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Searching...', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade800,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Railway Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        backgroundColor: Colors.blue.shade800,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              _buildDropdownField(
                label: 'Railway',
                value: selectedIreps,
                options: irepsOptions,
                onChanged: (newValue) {
                  setState(() {
                    selectedIreps = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdownField(
                label: 'Unit Type',
                value: selectedUnitType,
                options: unitTypeOptions,
                onChanged: (newValue) {
                  setState(() {
                    selectedUnitType = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdownField(
                label: 'Unit Name',
                value: selectedUnitName,
                options: unitNameOptions,
                onChanged: (newValue) {
                  setState(() {
                    selectedUnitName = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdownField(
                label: 'Department Name',
                value: selectedDepartment,
                options: departmentOptions,
                onChanged: (newValue) {
                  setState(() {
                    selectedDepartment = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdownField(
                label: 'User Depot',
                value: selectedUserDepot,
                options: userDepotOptions,
                onChanged: (newValue) {
                  setState(() {
                    selectedUserDepot = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'PL No/Description',
                  hintText: 'Enter PL/ minimum 3 letters',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least 3 letters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Get Details',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade700,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _resetForm,
                  child: Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade500,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> options,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      value: value,
      items: options
          .map((option) => DropdownMenuItem(
        value: option,
        child: Text(option),
      ))
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select an option' : null,
    );
  }
}