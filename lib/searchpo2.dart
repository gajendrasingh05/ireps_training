import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PO Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const POSearchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class POSearchPage extends StatelessWidget {
  const POSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PO Search',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Header
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade200.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      icon: Icons.receipt_long,
                      title: 'Total Count',
                      value: '2',
                      subtitle: 'record found',
                      iconColor: Colors.green,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade300.withOpacity(0.3),
                          Colors.grey.shade400.withOpacity(0.6),
                          Colors.grey.shade300.withOpacity(0.3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildSummaryCard(
                      icon: Icons.currency_rupee,
                      title: 'Total Value (Rs.)',
                      value: '282178.96',
                      subtitle: 'Total Amount',
                      iconColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          // PO Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: poItems.length,
              itemBuilder: (context, index) {
                return POItemCard(
                  item: poItems[index],
                  index: index + 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.blue.shade800.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 9,
            color: Colors.grey.shade500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class POItemCard extends StatelessWidget {
  final POItem item;
  final int index;

  const POItemCard({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with PO Number
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PO No. & Date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.poNumber,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        '${item.poDate} (IREPS)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Vendor Information
            _buildDetailRow('Vendor Name/Code', item.vendorName, Colors.green),
            const SizedBox(height: 12),

            // Details Grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem('PO Sr. No.', item.poSrNo, Colors.blue.shade800),
                ),
                Expanded(
                  child: _buildDetailItem('PL No.', item.plNo, Colors.blue.shade800),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Consignee Code', item.consigneeCode, Colors.blue.shade800),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildDetailItem('Item Quantity', item.itemQuantity, Colors.green),
                ),
                Expanded(
                  child: _buildDetailItem('Delivery Date', item.deliveryDate, Colors.blue.shade800),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildDetailItem('Item Unit Rate (Rs.)', item.itemUnitRate, Colors.green),
                ),
                Expanded(
                  child: _buildDetailItem('Item Value', item.itemValue, Colors.blue.shade800),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildDetailItem('Quantity Received', item.quantityReceived, Colors.blue.shade800),
                ),
                Expanded(
                  child: _buildDetailItem('Paid Value (Rs.)', item.paidValue, Colors.blue.shade800),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Item Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade800,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: item.description),
                      if (item.hasMore)
                        TextSpan(
                          text: '... More',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.featured_play_list, Colors.blue.shade300),
                _buildActionButton(Icons.arrow_forward, Colors.blue.shade300),
                _buildActionButton(Icons.share, Colors.blue.shade300),
                _buildActionButton(Icons.receipt, Colors.blue.shade300),
                _buildActionButton(Icons.warning, Colors.blue.shade300),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {},
      ),
    );
  }
}

class POItem {
  final String poNumber;
  final String poDate;
  final String vendorName;
  final String poSrNo;
  final String plNo;
  final String consigneeCode;
  final String itemQuantity;
  final String deliveryDate;
  final String itemUnitRate;
  final String itemValue;
  final String quantityReceived;
  final String paidValue;
  final String description;
  final bool hasMore;

  POItem({
    required this.poNumber,
    required this.poDate,
    required this.vendorName,
    required this.poSrNo,
    required this.plNo,
    required this.consigneeCode,
    required this.itemQuantity,
    required this.deliveryDate,
    required this.itemUnitRate,
    required this.itemValue,
    required this.quantityReceived,
    required this.paidValue,
    required this.description,
    this.hasMore = false,
  });
}

final List<POItem> poItems = [
  POItem(
    poNumber: '01151070100008',
    poDate: '28-04-2022',
    vendorName: 'M/S TEST BIDDER 1...-KANPUR',
    poSrNo: '001',
    plNo: '75544453',
    consigneeCode: '36640 : SSE-I/PS/NDLS',
    itemQuantity: '1139 Kgs.',
    deliveryDate: '06-08-2022',
    itemUnitRate: '88.00',
    itemValue: '100232',
    quantityReceived: '11939',
    paidValue: '0',
    description: 'COUNTRY JUTE TWINE 3 PLY VARIETY NO-6 OF TABLE NO-1 TO IS: 1912/1984 ( 2ND REVISION) AM.',
    hasMore: true,
  ),
  POItem(
    poNumber: '01151070100005',
    poDate: '13-04-2022',
    vendorName: 'M/S TEST BIDDER 1...-KANPUR',
    poSrNo: '002',
    plNo: '75544454',
    consigneeCode: '36640 : SSE-I/PS/NDLS',
    itemQuantity: '2000 Kgs.',
    deliveryDate: '15-08-2022',
    itemUnitRate: '91.00',
    itemValue: '181946',
    quantityReceived: '2000',
    paidValue: '181946',
    description: 'COUNTRY JUTE TWINE 3 PLY VARIETY NO-6 OF TABLE NO-1 TO IS: 1912/1984 ( 2ND REVISION) AM.',
    hasMore: true,
  ),
];