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
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: const StockPositionScreen(),
    );
  }
}

class StockPositionScreen extends StatefulWidget {
  const StockPositionScreen({Key? key}) : super(key: key);

  @override
  State<StockPositionScreen> createState() => _StockPositionScreenState();
}

class _StockPositionScreenState extends State<StockPositionScreen> {
  String _selectedSearchCriteria = 'PL Number';
  final List<String> _searchOptions = ['PL Number', 'Description'];

  // Controllers for text fields
  final TextEditingController _plNumberController = TextEditingController();
  final TextEditingController _description1Controller = TextEditingController();
  final TextEditingController _description2Controller = TextEditingController();
  final TextEditingController _description3Controller = TextEditingController();

  // Dropdown value
  String? _selectedDropdownValue;
  final List<String> _dropdownOptions = ['Option 1', 'Option 2', 'Option 3', 'Option 4', 'Option 5'];

  @override
  void dispose() {
    _plNumberController.dispose();
    _description1Controller.dispose();
    _description2Controller.dispose();
    _description3Controller.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _plNumberController.clear();
      _description1Controller.clear();
      _description2Controller.clear();
      _description3Controller.clear();
      _selectedDropdownValue = null;
    });
  }

  void _submitForm() {
    // Implementation for form submission would go here
    // For demonstration, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_selectedSearchCriteria == 'PL Number'
            ? 'Searching for PL Number: ${_plNumberController.text}'
            : 'Searching for Description'),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
        title: const Text(
          'View Stock Position',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Select Search criteria:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            _buildSearchTabs(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _selectedSearchCriteria == 'PL Number'
                  ? _buildPLNumberForm()
                  : _buildDescriptionForm(),
            ),
            const SizedBox(height: 16),
            _buildButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: _searchOptions.map((option) {
          bool isSelected = _selectedSearchCriteria == option;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSearchCriteria = option;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.teal : Colors.white,
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPLNumberForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          isDropdown: true,
          label: 'Select Zone', // Changed from 'Select' to 'Select Zone'
          icon: Icons.train, // Changed from Icons.filter_list to Icons.train
        ),
        const SizedBox(height: 16),
        _buildInputField(
          controller: _plNumberController,
          label: 'Enter PL Number',
          icon: Icons.confirmation_number_outlined,
        ),
      ],
    );
  }

  Widget _buildDescriptionForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          isDropdown: true,
          label: 'Select Zone', // Changed from 'Select' to 'Select Zone'
          icon: Icons.train, // Changed from Icons.filter_list to Icons.train
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Enter Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.teal,
            ),
          ),
        ),
        _buildInputField(
          controller: _description1Controller,
          label: 'Enter description1',
          icon: Icons.description_outlined,
        ),
        _buildConnector('And'),
        _buildInputField(
          controller: _description2Controller,
          label: 'Enter description2',
          icon: Icons.description_outlined,
        ),
        _buildConnector('And'),
        _buildInputField(
          controller: _description3Controller,
          label: 'Enter description3',
          icon: Icons.description_outlined,
        ),
      ],
    );
  }

  // Unified method to create consistent input fields
  Widget _buildInputField({
    TextEditingController? controller,
    required String label,
    required IconData icon,
    bool isDropdown = false,
  }) {
    // Define consistent height for all input fields
    const double fieldHeight = 50.0;

    return Container(
      height: fieldHeight,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: isDropdown
          ? DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<String>(
            value: _selectedDropdownValue,
            hint: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.teal, size: 20),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.teal),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              isDense: false,
              alignLabelWithHint: true,
            ),
            isExpanded: true,
            items: _dropdownOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedDropdownValue = newValue;
              });
            },
          ),
        ),
      )
          : SizedBox(
        height: fieldHeight,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: Icon(icon, color: Colors.teal, size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            isDense: true,
          ),
        ),
      ),
    );
  }

  Widget _buildConnector(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _resetForm,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.teal,
                side: BorderSide(color: Colors.teal.shade800),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Reset',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}