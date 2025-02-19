import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomSearchPage(),
  ));
}

class CustomSearchPage extends StatefulWidget {
  @override
  _CustomSearchPageState createState() => _CustomSearchPageState();
}

class _CustomSearchPageState extends State<CustomSearchPage> {
  String selectedWorkArea = 'Goods & Services';
  String selectedDateType = 'uploading';
  DateTime closingDate = DateTime(2025, 1, 28);
  DateTime uploadingDate = DateTime(2025, 1, 29);
  bool showTenderNo = false;
  bool showItemDesc = false;
  String? selectedOrganisation;

  void resetForm() {
    setState(() {
      showTenderNo = false;
      showItemDesc = false;
      selectedWorkArea = 'Goods & Services';
      selectedDateType = 'uploading';
      closingDate = DateTime(2025, 1, 28);
      uploadingDate = DateTime(2025, 1, 29);
      selectedOrganisation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Custom Search",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Search Criteria",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                if (!showTenderNo)
                  Expanded(
                    child: _buildExpandableButton(
                      title: "Tender No",
                      onPressed: () {
                        setState(() {
                          showTenderNo = true;
                        });
                      },
                    ),
                  ),
                if (!showTenderNo && !showItemDesc)
                  SizedBox(width: 8),
                if (!showItemDesc)
                  Expanded(
                    child: _buildExpandableButton(
                      title: "Item Desc",
                      onPressed: () {
                        setState(() {
                          showItemDesc = true;
                        });
                      },
                    ),
                  ),
              ],
            ),
            if (showTenderNo || showItemDesc)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showTenderNo) ...[
                    SizedBox(height: 8),
                    _buildTextField("Enter Tender No"),
                  ],
                  if (showItemDesc) ...[
                    SizedBox(height: 8),
                    _buildTextField("Enter Item Description"),
                  ],
                  SizedBox(height: 12),
                ],
              ),
            SizedBox(height: 16),
            Text(
              "Select Work Area",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            _buildWorkAreaSelection(),
            SizedBox(height: 16),
            _buildOrganisationDropdown(),
            _buildDropdownTile(Icons.train, "Select Railway"),
            _buildDropdownTile(Icons.account_balance, "Select Department"),
            _buildDropdownTile(Icons.location_city, "Select Unit"),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                children: [
                  TextSpan(text: "Select Tender Date Criteria"),
                  TextSpan(
                    text: " (Maximum difference 30 days)",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            _buildDateTypeSelection(),
            SizedBox(height: 12),
            _buildDateSelection(),
            SizedBox(height: 24),
            _buildActionButton("Show Results", Colors.blue.shade800),
            SizedBox(height: 8),
            _buildActionButton("Reset", Colors.blue.shade400, onPressed: resetForm),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganisationDropdown() {
    List<String> organisations = [
      "KRCL",
      "DMRC",
      "MRVC",
      "CRIS",
      "RAILTEL",
      "DFCCIL",
      "KERALA RAIL DEVELOPMENT CORPORATION LTD",
      "CONTAINER CORPORATION OF INDIA LTD",
      "BRAITHWAITE AND CO. LIMITED",
      "IRCON INTERNATIONAL LIMITED",
      "INDIAN RAILWAY CATERING AND TOURISM CORPORATION LTD",
      "INDIAN RAILWAY FINANCE CORPORATION",
      "KOLKATA METRO RAIL CORPORATION LTD"
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        leading: Icon(Icons.list, color: Colors.blue.shade800, size: 20),
        title: DropdownButton<String>(
          value: selectedOrganisation,
          hint: Text("Select Organisation", style: TextStyle(fontSize: 14)),
          isExpanded: true,
          underline: SizedBox(), // Remove the default underline
          items: organisations.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedOrganisation = newValue;
            });
          },
        ),
        // Removed the trailing arrow here
      ),
    );
  }

  Widget _buildDateTypeSelection() {
    return Row(
      children: [
        Expanded(
          child: _buildDateTypeOption(
            title: "Uploading Date",
            value: "uploading",
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildDateTypeOption(
            title: "Closing Date",
            value: "closing",
          ),
        ),
      ],
    );
  }

  Widget _buildDateTypeOption({
    required String title,
    required String value,
  }) {
    bool isSelected = selectedDateType == value;
    return InkWell(
      onTap: () {
        setState(() {
          selectedDateType = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Colors.blue.shade400 : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.blue.shade400,
                size: 18,
              ),
            if (!isSelected)
              Icon(
                Icons.circle_outlined,
                color: Colors.grey.shade400,
                size: 18,
              ),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.blue.shade700 : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintText: hint,
        filled: true,
        fillColor: Colors.blue.shade50,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        hintStyle: TextStyle(fontSize: 13),
      ),
      style: TextStyle(fontSize: 13),
    );
  }

  Widget _buildWorkAreaSelection() {
    List<String> areas = ["Goods & Services", "Works", "Earning/Leasing"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: areas.map((area) => _buildChip(area)).toList(),
    );
  }

  Widget _buildChip(String title) {
    return ChoiceChip(
      label: Text(
        title,
        style: TextStyle(fontSize: 13),
      ),
      selected: selectedWorkArea == title,
      selectedColor: Colors.blue.shade300,
      showCheckmark: false,
      onSelected: (selected) {
        setState(() {
          selectedWorkArea = title;
        });
      },
    );
  }

  Widget _buildDropdownTile(IconData icon, String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        leading: Icon(icon, color: Colors.blue.shade800, size: 20),
        title: Text(title, style: TextStyle(fontSize: 14)),
        trailing: Icon(Icons.arrow_drop_down, size: 20),
        onTap: () {},
      ),
    );
  }

  Widget _buildDateSelection() {
    return Row(
      children: [
        Expanded(
          child: _buildDatePicker(
            uploadingDate,
            false,
            "From        ",
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildDatePicker(
            closingDate,
            true,
            "To            ",
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(DateTime date, bool isClosing, String label) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2024),
          lastDate: DateTime(2026),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.blue.shade800,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.blue.shade800,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          setState(() {
            if (isClosing) {
              closingDate = pickedDate;
            } else {
              uploadingDate = pickedDate;
            }
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "${date.toLocal()}".split(' ')[0],
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(Icons.calendar_today, color: Colors.blue.shade800, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, {VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed ?? () {},
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}