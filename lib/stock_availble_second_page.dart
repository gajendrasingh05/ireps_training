import 'package:flutter/material.dart';

class NonMovingItemsPage extends StatefulWidget {
  @override
  _NonMovingItemsPageState createState() => _NonMovingItemsPageState();
}

class _NonMovingItemsPageState extends State<NonMovingItemsPage> {
  List<bool> isDescriptionExpanded = [false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(
          'Stock Availability',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
        elevation: 2,
      ),
      body: Column(
        children: [
          // Compact Summary Cards
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(Icons.inventory, color: Colors.green, size: 16),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Records',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '1',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(Icons.currency_rupee, color: Colors.green, size: 16),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Value',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '₹59,154.50',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Compact Items List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Compact Consignee Header
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.blue[100]!, width: 1),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.blue[600],
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Consignee Depot',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  Text(
                                    'SSE/EPS/UD • 36640 - Mechanical • IREPS-TESTING',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      // Compact Info Grid
                      Column(
                        children: [
                          // Ledger Info
                          _buildCompactInfoRow(
                            'Ledger No. / Ledger Folio No.',
                            '001 Consumable Items1 • 0001 Liquid Soap',
                            isSingle: true,
                            valueColor: Colors.blue[700],
                          ),
                          SizedBox(height: 8),

                          // Two column layout for compact display
                          Row(
                            children: [
                              Expanded(
                                child: _buildCompactInfoColumn(
                                  'PL No./Item Code',
                                  '539800130013',
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _buildCompactInfoColumn(
                                  'Stock/Non-Stock',
                                  'Non-Stock',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          Row(
                            children: [
                              Expanded(
                                child: _buildCompactInfoColumn(
                                  'Last Receipt',
                                  '15-02-2023',
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _buildCompactInfoColumn(
                                  'Last Issue',
                                  '24-09-2022',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          Row(
                            children: [
                              Expanded(
                                child: _buildCompactInfoColumn(
                                  'Stock/UNIT',
                                  '678.000 Nos.',
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _buildCompactInfoColumn(
                                  'रेट सीमा',
                                  '1.000',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          Row(
                            children: [
                              Expanded(
                                child: _buildCompactInfoColumn(
                                  'Average Rate (Rs.)',
                                  '87.25',
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _buildCompactInfoColumn(
                                  'Value (Rs.)',
                                  '₹59,154.50',
                                  valueColor: Colors.green[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Compact Description
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Brief Description',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                isDescriptionExpanded[0]
                                    ? 'Liquid Soap : TWINE CORE SHIELDED MICROPHONE CABLE(RED & BLACK) EACH CORE SHALL BE 23/36 SWG PVC INSULATED COPPER CONDUCTOR ON OVERALL PVC JACKET..'
                                    : 'Liquid Soap : TWINE CORE SHIELDED MICROPHONE CABLE(RED & BLACK) EACH CORE SHALL BE 23/36 SWG...',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 3),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDescriptionExpanded[0] = !isDescriptionExpanded[0];
                                  });
                                },
                                child: Text(
                                  isDescriptionExpanded[0] ? 'less' : 'see more',
                                  style: TextStyle(
                                    color: Colors.blue[600],
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactInfoRow(String label, String value, {bool isSingle = false, Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.grey[800],
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactInfoColumn(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.grey[800],
          ),
        ),
      ],
    );
  }
}

// Usage Example
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Non-Moving Items',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NonMovingItemsPage(),
    );
  }
}

void main() {
  runApp(MyApp());
}