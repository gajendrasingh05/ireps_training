import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tender Search',
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: TenderSearchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TenderSearchPage extends StatefulWidget {
  @override
  _TenderSearchPageState createState() => _TenderSearchPageState();
}

class _TenderSearchPageState extends State<TenderSearchPage> {
  DateTime? startDate;
  DateTime? endDate;
  String? selectedOption;

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  var users = <String>[
    'Goods & Services',
    'Works',
    'Earning/Leasing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'High Value Tender',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownSearch<String>(
                selectedItem: "Select Organization",
                items: (filter, infiniteScrollProps) => users,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: "Organization",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business, color: Colors.blue[800]),
                  ),
                ),
                popupProps: PopupProps.menu(
                    fit: FlexFit.loose, constraints: BoxConstraints()),
              ),
              SizedBox(height: 20),
              DropdownSearch<String>(
                selectedItem: "Select Zone",
                items: (filter, infiniteScrollProps) => users,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: "Zone",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on, color: Colors.blue[800]),
                  ),
                ),
                popupProps: PopupProps.menu(
                    fit: FlexFit.loose, constraints: BoxConstraints()),
              ),
              SizedBox(height: 20),
              DropdownSearch<String>(
                selectedItem: "Select Department",
                items: (filter, infiniteScrollProps) => users,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: "Department",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.apartment, color: Colors.blue[800]),
                  ),
                ),
                popupProps: PopupProps.menu(
                    fit: FlexFit.loose, constraints: BoxConstraints()),
              ),
              SizedBox(height: 20),
              DropdownSearch<String>(
                selectedItem: "Select Unit",
                items: (filter, infiniteScrollProps) => users,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: "Unit",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.grid_view, color: Colors.blue[800]),
                  ),
                ),
                popupProps: PopupProps.menu(
                    fit: FlexFit.loose, constraints: BoxConstraints()),
              ),
              SizedBox(height: 25),
              Row(
                children: users.map((option) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedOption = option;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: selectedOption == option
                                ? Colors.blue[800]
                                : Colors.blue[50],
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: selectedOption == option
                                  ? Colors.blue[900]!
                                  : Colors.blue[100]!,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              option,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedOption == option
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),
              Text(
                'Publish Date Range',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      'From',
                      startDate,
                          (date) => setState(() => startDate = date),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDatePicker(
                      'To',
                      endDate,
                          (date) => setState(() => endDate = date),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Show Results',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    startDate = null;
                    endDate = null;
                    selectedOption = null;
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.blue[800]!),
                  ),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(
      String label,
      DateTime? selectedDate,
      Function(DateTime) onDateSelected,
      ) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 20, color: Colors.blue[800]),
            SizedBox(width: 8),
            Text(
              selectedDate != null ? formatDate(selectedDate) : label,
              style: TextStyle(
                color: selectedDate != null ? Colors.black87 : Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}