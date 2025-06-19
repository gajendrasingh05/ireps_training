import 'package:flutter/material.dart';

void main() {
  runApp(const RailwayBillApp());
}

class RailwayBillApp extends StatelessWidget {
  const RailwayBillApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Railway Bill Summary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RailwayBillSummaryPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RailwayBillSummaryPage extends StatelessWidget {
  const RailwayBillSummaryPage({Key? key}) : super(key: key);

  // Sample data for the list - you can replace this with your actual data
  final List<Map<String, dynamic>> billsData = const [
    {
      'railway': 'IREPS',
      'unitName': 'EPS/UD',
      'department': 'Mechanical',
      'consignee': 'SR. SECTION\nENGINEER-I/PS/NEW\nDELHI',
      'payingAuthority': 'Test Finance Cris:\nA2001 (AU: 0101)',
      'poNumber': '011510611000002',
      'vendorName': 'TEST BIDDER 1.-\nKANPUR',
      'poSiNo': '001',
      'docType': 'CRN',
      'docNumber': '36640-23-00093',
      'billNumber': '789',
      'irepsBillNumber': '1620158 - NA',
      'srNo': '1',
      'qty': '1',
      'billAmount': '₹10.00',
      'description': 'RUBBER HOSE FOR WELDING AND CUTTING WITH BARIDED TEXTILE REINFORCEMENT',
      'openingBalance': '3',
      'billsReceived': '1',
      'billsReturned': '0',
      'billsPassed': '0',
      'pendingBills': '4',
      'lessThan7Days': '0',
      'days7to15': '0',
      'days15to30': '0',
      'moreThan30Days': '4',
    },
    {
      'railway': 'IREPS',
      'unitName': 'EPS/UD',
      'department': 'Electrical',
      'consignee': 'SR. SECTION\nENGINEER-II/PS/NEW\nDELHI',
      'payingAuthority': 'Test Finance Cris:\nA2002 (AU: 0102)',
      'poNumber': '011510611000003',
      'vendorName': 'TEST BIDDER 2.-\nMUMBAI',
      'poSiNo': '002',
      'docType': 'CRN',
      'docNumber': '36640-23-00094',
      'billNumber': '790',
      'irepsBillNumber': '1620159 - NA',
      'srNo': '1',
      'qty': '2',
      'billAmount': '₹25.00',
      'description': 'ELECTRICAL CABLES FOR RAILWAY SIGNAL SYSTEM WITH COPPER CONDUCTOR',
      'openingBalance': '5',
      'billsReceived': '2',
      'billsReturned': '1',
      'billsPassed': '1',
      'pendingBills': '5',
      'lessThan7Days': '1',
      'days7to15': '1',
      'days15to30': '2',
      'moreThan30Days': '1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'On-Line Bill Summary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: billsData.length,
        itemBuilder: (context, index) {
          final billData = billsData[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Card with left margin to accommodate the circle
                Container(
                  margin: const EdgeInsets.only(left: 16), // Space for the circle
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12), // Space at top for circle alignment

                          // Main Bill Details Card
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header Section with Serial Number
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[400],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.train, color: Colors.white, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        'IREPS - Railway Bill Details ${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Bill Information Grid
                                _buildInfoGrid([
                                  {'label': 'Railway', 'value': billData['railway']},
                                  {'label': 'Unit Name', 'value': billData['unitName']},
                                  {'label': 'Department', 'value': billData['department']},
                                  {'label': 'Consignee', 'value': billData['consignee']},
                                ]),

                                const Divider(height: 20, thickness: 1),

                                _buildInfoGrid([
                                  {'label': 'Paying Authority', 'value': billData['payingAuthority']},
                                  {'label': 'PO No. & Date', 'value': billData['poNumber']},
                                  {'label': 'Vendor Name', 'value': billData['vendorName']},
                                  {'label': 'PO SI. No.', 'value': billData['poSiNo']},
                                ]),

                                const Divider(height: 20, thickness: 1),

                                _buildInfoGrid([
                                  {'label': 'Doc. Type', 'value': billData['docType']},
                                  {'label': 'Doc. No. & Date', 'value': billData['docNumber']},
                                  {'label': 'Bill No. & Date', 'value': billData['billNumber']},
                                  {'label': 'IREPS Bill No. & Date', 'value': billData['irepsBillNumber']},
                                ]),

                                const Divider(height: 20, thickness: 1),

                                // IREPS Bill Details with equal spacing
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: _buildInfoItem({'label': 'IREPS Bill Sr. No.', 'value': billData['srNo']}),
                                    ),
                                    const SizedBox(width: 50),
                                    Expanded(
                                      flex: 1,
                                      child: _buildInfoItem({'label': 'Qty', 'value': billData['qty']}),
                                    ),
                                    const SizedBox(width: 0),
                                    Expanded(
                                      flex: 1,
                                      child: _buildInfoItem({'label': 'Bill Amt.', 'value': billData['billAmount'], 'isAmount': true}),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                const Divider(height: 20, thickness: 1),

                                // Item Description at the bottom
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue[800],
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  billData['description'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Bill Status Summary Card
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[400],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.assessment, color: Colors.white, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        'Bill Status Summary',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Bill Status Grid
                                Row(
                                  children: [
                                    Expanded(child: _buildStatusCard('Opening Balance', billData['openingBalance'], Colors.blue[700]!, context)),
                                    const SizedBox(width: 12),
                                    Expanded(child: _buildStatusCard('Bills Received', billData['billsReceived'], Colors.green[700]!, context)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(child: _buildStatusCard('Bills Returned', billData['billsReturned'], Colors.orange[700]!, context)),
                                    const SizedBox(width: 12),
                                    Expanded(child: _buildStatusCard('Bills Passed', billData['billsPassed'], Colors.purple[700]!, context)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Centered Pending Bills card
                                Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.4, // Adjust width as needed
                                    child: _buildStatusCard('Pending Bills', billData['pendingBills'], Colors.red[700]!, context),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Pending Bills Breakdown Card
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[400],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.pending_actions, color: Colors.white, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        'Break-up of Pending Bills',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Pending Bills Grid - Now with equal sizing matching status cards
                                Row(
                                  children: [
                                    Expanded(child: _buildPendingCard('< 7 Days', billData['lessThan7Days'], Colors.green[700]!, context)),
                                    const SizedBox(width: 12),
                                    Expanded(child: _buildPendingCard('7 to 15 Days', billData['days7to15'], Colors.yellow[800]!, context)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(child: _buildPendingCard('15 to 30 Days', billData['days15to30'], Colors.orange[700]!, context)),
                                    const SizedBox(width: 12),
                                    Expanded(child: _buildPendingCard('> 30 Days', billData['moreThan30Days'], Colors.red[700]!, context)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Circle positioned at the left corner of the main card
                Positioned(
                  top: 8, // Position closer to the top corner
                  left: 0, // Position at the very left edge
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.blue[800]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoGrid(List<Map<String, dynamic>> items) {
    return Column(
      children: [
        for (int i = 0; i < items.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildInfoItem(items[i]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: i + 1 < items.length ? _buildInfoItem(items[i + 1]) : Container(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStatusCard(String title, String value, Color textColor, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle navigation to another page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navigating to $title details...'),
            backgroundColor: Colors.blue[800],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingCard(String period, String count, Color textColor, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle navigation to another page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navigating to $period pending bills...'),
            backgroundColor: Colors.orange[800],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              period,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(Map<String, dynamic> item) {
    final bool isAmount = item['isAmount'] ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item['label'].isNotEmpty)
          Text(
            item['label'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.blue[800],
              letterSpacing: 0.3,
            ),
          ),
        if (item['label'].isNotEmpty) const SizedBox(height: 4),
        if (item['value'].isNotEmpty)
          Text(
            item['value'],
            style: TextStyle(
              fontSize: isAmount ? 16 : 14,
              fontWeight: isAmount ? FontWeight.bold : FontWeight.w500,
              color: isAmount ? Colors.green[700] : Colors.black87,
              height: 1.3,
            ),
          ),
      ],
    );
  }
}