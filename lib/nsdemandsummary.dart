import 'package:flutter/material.dart';

void main() {
  runApp(const NSDemandApp());
}

class NSDemandApp extends StatelessWidget {
  const NSDemandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NS Demand Summary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const NSDemandFormPage(),
    );
  }
}

class NSDemandFormPage extends StatefulWidget {
  const NSDemandFormPage({super.key});

  @override
  State<NSDemandFormPage> createState() => _NSDemandFormPageState();
}

class _NSDemandFormPageState extends State<NSDemandFormPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 1));

  String? railway;
  String? unitType;
  String? unitName;
  String? department;
  String? consigneeCode;
  String? indentorName;

  final blueBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue.shade800),
    borderRadius: BorderRadius.circular(10),
  );

  Future<void> pickDate(bool isFrom) async {
    DateTime initial = isFrom ? fromDate : toDate;
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Widget buildDatePickerWithLabel(String label, DateTime date, bool isFrom) {
    return Expanded(
      child: InkWell(
        onTap: () => pickDate(isFrom),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.blue.shade800),
            border: blueBorder,
            enabledBorder: blueBorder,
            focusedBorder: blueBorder,
            suffixIcon: Icon(Icons.calendar_today, color: Colors.blue.shade800),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          child: Text(
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> options, String? value, ValueChanged<String?> onChanged) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue.shade800),
        border: blueBorder,
        enabledBorder: blueBorder,
        focusedBorder: blueBorder,
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text("Select $label"),
          iconEnabledColor: Colors.blue.shade800,
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void resetForm() {
    setState(() {
      railway = null;
      unitType = null;
      unitName = null;
      department = null;
      consigneeCode = null;
      indentorName = null;
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(days: 1));
    });
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          "NS Demand Summary",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Or custom back logic
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Handle home navigation
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // NS Demand Date Section
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 6,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NS Demand Date",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                buildDatePickerWithLabel("From", fromDate, true),
                                const SizedBox(width: 16),
                                buildDatePickerWithLabel("To", toDate, false),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Form Section (Dropdowns)
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 6,
                      margin: const EdgeInsets.all(4),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            buildDropdownField("Railway", ["IREPS-TESTING"], railway, (val) => setState(() => railway = val)),
                            const SizedBox(height: 16),
                            buildDropdownField("Unit Type", ["Zonal HQ / PU HQ"], unitType, (val) => setState(() => unitType = val)),
                            const SizedBox(height: 16),
                            buildDropdownField("Unit Name", ["EPS/UD"], unitName, (val) => setState(() => unitName = val)),
                            const SizedBox(height: 16),
                            buildDropdownField("Select Department", ["Mechanical"], department, (val) => setState(() => department = val)),
                            const SizedBox(height: 16),
                            buildDropdownField("Indenting Consignee Code", [
                              "36640-SR. SECTION ENGINEER-I/PS/"
                            ], consigneeCode, (val) => setState(() => consigneeCode = val)),
                            const SizedBox(height: 16),
                            buildDropdownField("Indentor's Name", ["All"], indentorName, (val) => setState(() => indentorName = val)),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Submit & Reset Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              // Submit logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade800,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Submit", style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: resetForm,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue.shade800,
                              side: BorderSide(color: Colors.blue.shade800),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Reset", style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
