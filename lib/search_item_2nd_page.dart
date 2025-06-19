import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item-List',
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
      home: const NonMovingItemsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NonMovingItemsPage extends StatelessWidget {
  const NonMovingItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      InventoryItem(
        id: 1,
        department: 'Mechanical',
        railway: 'IREPS-TESTING',
        userDepot: 'SSE/EPS/UD',
        consigneeCode: 'C001',
        plNo: '000200010013',
        ledgerName: '021-Test Ledger 27',
        itemCategory: '10-ORDINARY NEW STORES',
        itemDescription: 'Test Folio : Tender Axle Boxes and details.',
        rate: 129.65,
        qty: '26 Nos.',
      ),
      InventoryItem(
        id: 2,
        department: 'Mechanical',
        railway: 'IREPS-TESTING',
        userDepot: 'SSE/EPS/UD',
        consigneeCode: 'C002',
        plNo: '01070123',
        ledgerName: '001-Consumeble Items1',
        itemCategory: '10-ORDINARY NEW STORES',
        itemDescription: 'Liquid Soap : TEST/2007',
        rate: 0,
        qty: '25 Nos.',
      ),
    ];

    final totalValue = 589693840.52;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Item List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.inventory_2,
                    title: 'Total Count',
                    value: '63',
                    subtitle: 'record found',
                    iconColor: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.currency_rupee,
                    title: 'Total Value (Rs.)',
                    value: totalValue.toStringAsFixed(2),
                    subtitle: '',
                    iconColor: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: InventoryItemCard(
                    item: items[index],
                    index: index + 1,
                  ),
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
    return Container(
      height: 75,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InventoryItemCard extends StatelessWidget {
  final InventoryItem item;
  final int index;

  const InventoryItemCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.07),
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Consignee Code: ${item.consigneeCode}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Department: ${item.department}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Railway: ${item.railway}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'User Depot: ${item.userDepot}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.blue.shade700,
                      size: 22,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildDetailItem('PL No./Item Code', item.plNo, Colors.black),
                ),
                Expanded(
                 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Category',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.itemCategory,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildDetailItem(
                    'Rate',
                    '₹${item.rate.toStringAsFixed(2)}',
                    Colors.green.shade700,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem('Quantity', item.qty, Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ledger Name',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.ledgerName,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Item Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.itemDescription,
              style: TextStyle(
                fontSize: 13,
                color: Colors.blueGrey.shade700,
                height: 1.4,
              ),
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
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey.shade600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class InventoryItem {
  final int id;
  final String department;
  final String railway;
  final String userDepot;
  final String consigneeCode;
  final String plNo;
  final String ledgerName;
  final String itemCategory;
  final String itemDescription;
  final double rate;
  final String qty;

  InventoryItem({
    required this.id,
    required this.department,
    required this.railway,
    required this.userDepot,
    required this.consigneeCode,
    required this.plNo,
    required this.ledgerName,
    required this.itemCategory,
    required this.itemDescription,
    required this.rate,
    required this.qty,
  });
}
