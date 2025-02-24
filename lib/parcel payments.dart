import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcel Payment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        useMaterial3: true,
      ),
      home: const ParcelPaymentPage(),
    );
  }
}

class ParcelPaymentPage extends StatefulWidget {
  const ParcelPaymentPage({super.key});

  @override
  State<ParcelPaymentPage> createState() => _ParcelPaymentPageState();
}

class _ParcelPaymentPageState extends State<ParcelPaymentPage> {
  final TextEditingController _trainController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String _selectedValue = 'F1';
  bool _isSLRSelected = true;

  @override
  void initState() {
    super.initState();
    _dateController.text = '24/02/2025';
  }

  @override
  void dispose() {
    _trainController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _trainController.clear();
      _dateController.text = '24/02/2025';
      _selectedValue = 'F1';
      _isSLRSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: const Text(
          'Parcel Payments',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Train Number Field
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: TextField(
                  controller: _trainController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.train, color: Color(0xFF1976D2), size: 20),
                    hintText: 'Train No.',
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // SLR/VP Toggle
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isSLRSelected = true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _isSLRSelected
                                ? const Color(0xFF1976D2)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(7),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'SLR',
                              style: TextStyle(
                                color: _isSLRSelected ? Colors.white : Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isSLRSelected = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !_isSLRSelected
                                ? const Color(0xFF1976D2)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(7),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'VP',
                              style: TextStyle(
                                color: !_isSLRSelected ? Colors.white : Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Value Dropdown
              Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Value',
                    labelStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  value: _selectedValue,
                  items: ['F1'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedValue = value!);
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Date Field
              Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _dateController,
                  readOnly: true,
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF1976D2), size: 20),
                    hintText: 'Date',
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2026),
                    );
                    if (picked != null) {
                      setState(() {
                        _dateController.text =
                        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              Container(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement submit logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Reset Button
              Container(
                height: 45,
                child: OutlinedButton(
                  onPressed: _resetForm,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue.shade300),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
}