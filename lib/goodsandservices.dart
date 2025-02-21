import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryBlue = Colors.blue[800]!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Documents',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryBlue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: PublicDocumentsPage(),
    );
  }
}

class PublicDocumentsPage extends StatefulWidget {
  @override
  _PublicDocumentsPageState createState() => _PublicDocumentsPageState();
}

class _PublicDocumentsPageState extends State<PublicDocumentsPage> {
  String? selectedOrganization;
  String? selectedZone;
  String? selectedDepartment;

  final Color primaryBlue = Colors.blue[800]!;
  final Color secondaryBlue = Colors.blue[500]!; // Much lighter blue for secondary navbar
  final List<String> organizations = ['Organization A', 'Organization B', 'Organization C'];
  final List<String> zones = ['North Zone', 'South Zone', 'East Zone', 'West Zone'];
  final List<String> departments = ['Finance', 'Healthcare', 'Education', 'Transport'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Public Documents',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: primaryBlue,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Handle home navigation
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Container(
            color: secondaryBlue,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Row(
              children: [
                //Icon(Icons.inventory_2, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  'Goods and Services',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDropdownField(
                icon: Icons.business,
                label: 'Organization',
                value: selectedOrganization,
                items: organizations,
                onChanged: (value) {
                  setState(() => selectedOrganization = value);
                },
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                icon: Icons.location_on,
                label: 'Zone',
                value: selectedZone,
                items: zones,
                onChanged: (value) {
                  setState(() => selectedZone = value);
                },
              ),
              const SizedBox(height: 20),
              _buildDropdownField(
                icon: Icons.account_balance,
                label: 'Department',
                value: selectedDepartment,
                items: departments,
                onChanged: (value) {
                  setState(() => selectedDepartment = value);
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Handle show results
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Show Results',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedOrganization = null;
                    selectedZone = null;
                    selectedDepartment = null;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
    required IconData icon,
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryBlue.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: primaryBlue),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  hint: Text(
                    'Select $label',
                    style: TextStyle(
                      color: primaryBlue.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down, color: primaryBlue),
                  items: items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}