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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Main Bill Details Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.train, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'IREPS - Railway Bill Details',
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

                    // Bill Information Grid
                    _buildInfoGrid([
                      {'label': 'Railway', 'value': 'IREPS'},
                      {'label': 'Unit Name', 'value': 'EPS/UD'},
                      {'label': 'Department', 'value': 'Mechanical'},
                      {'label': 'Consignee', 'value': 'SR. SECTION\nENGINEER-I/PS/NEW\nDELHI'},
                    ]),

                    const Divider(height: 20, thickness: 1),

                    _buildInfoGrid([
                      {'label': 'Paying Authority', 'value': 'Test Finance Cris:\nA2001 (AU: 0101)'},
                      {'label': 'PO No. & Date', 'value': '011510611000002'},
                      {'label': 'Vendor Name', 'value': 'TEST BIDDER 1.-\nKANPUR'},
                      {'label': 'PO SI. No.', 'value': '001'},
                    ]),

                    const Divider(height: 20, thickness: 1),

                    _buildInfoGrid([
                      {'label': 'Doc. Type', 'value': 'CRN'},
                      {'label': 'Doc. No. & Date', 'value': '36640-23-00093'},
                      {'label': 'Bill No. & Date', 'value': '789'},
                      {'label': 'IREPS Bill No. & Date', 'value': '1620158 - NA'},
                    ]),

                    const Divider(height: 20, thickness: 1),

                    // IREPS Bill Details with equal spacing - FIXED
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: _buildInfoItem({'label': 'IREPS Bill Sr. No.', 'value': '1'}),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          flex: 1,
                          child: _buildInfoItem({'label': 'Qty', 'value': '1'}),
                        ),
                        const SizedBox(width: 0),
                        Expanded(
                          flex: 1,
                          child: _buildInfoItem({'label': 'Bill Amt.', 'value': '₹10.00', 'isAmount': true}),
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
                    const Text(
                      'RUBBER HOSE FOR WELDING AND CUTTING WITH BARIDED TEXTILE REINFORCEMENT',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Bill Status Summary Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                        Expanded(child: _buildStatusCard('Opening Balance', '3', Colors.blue[700]!)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatusCard('Bills Received', '1', Colors.green[700]!)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildStatusCard('Bills Returned', '0', Colors.orange[700]!)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatusCard('Bills Passed', '0', Colors.purple[700]!)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Container()), // Empty space to center the card
                        Expanded(flex: 2, child: _buildStatusCard('Pending Bills', '4', Colors.red[700]!)),
                        Expanded(flex: 1, child: Container()), // Empty space to center the card
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Pending Bills Breakdown Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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

                    // Pending Bills Grid
                    Row(
                      children: [
                        Expanded(child: _buildPendingCard('< 7 Days', '0', Colors.green[700]!)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildPendingCard('7 to 15 Days', '0', Colors.yellow[800]!)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildPendingCard('15 to 30 Days', '0', Colors.orange[700]!)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildPendingCard('> 30 Days', '4', Colors.red[700]!)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80), // Extra space for floating button
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[800]!.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Handle next button press
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Navigating to next page...'),
                backgroundColor: Colors.blue[800],
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

  Widget _buildStatusCard(String title, String value, Color textColor, {bool isFullWidth = false}) {
    return Container(
      width: isFullWidth ? double.infinity : null,
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
    );
  }

  Widget _buildPendingCard(String period, String count, Color textColor) {
    return Container(
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
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

  Widget _buildStatusRow(String label, String value, {bool isHighlight = false, bool isUrgent = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHighlight || isUrgent ? FontWeight.w600 : FontWeight.w500,
              color: isUrgent ? Colors.red[700] : Colors.black87,
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isUrgent
                      ? Colors.red[50]
                      : isHighlight
                      ? Colors.orange[50]
                      : Colors.blue[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isUrgent
                        ? Colors.red[200]!
                        : isHighlight
                        ? Colors.orange[200]!
                        : Colors.blue[200]!,
                  ),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isUrgent
                        ? Colors.red[700]
                        : isHighlight
                        ? Colors.orange[700]
                        : Colors.blue[700],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.grey[400],
              ),
            ],
          ),
        ],
      ),
    );
  }
}